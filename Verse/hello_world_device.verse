using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /EpicGames.com/Temporary/UI}
using { /Fortnite.com/UI }
using {/EpicGames.com/Temporary/SpatialMath }
using {/Fortnite.com/Characters }
using { /Fortnite.com/Devices/CreativeAnimation }

#Create a widget that shows the killstreaks available.  

#Use the device used in the MrBeast video where you can fly around. We first get the Z, then give them the phone to set the X and Y.
#If someone already called in a killstreak such as Cruise Missile, error that air space is crowded.


#Idea - Create a death camera whenever someone gets killed by an enemy, it shows a camera perspective around the enemy such as in CS:GO.

killstreak_device := class(creative_device):
    @editable Button : button_device = button_device{}
    @editable HUDControl : hud_controller_device = hud_controller_device{}
    @editable CineMissle : cinematic_sequence_device = cinematic_sequence_device{}
    @editable CineRespawnSequence : cinematic_sequence_device = cinematic_sequence_device{}
    @editable CineSeqTesting : cinematic_sequence_device = cinematic_sequence_device{}
    @editable CruiseExplosive : explosive_device = explosive_device{}
    @editable TeamSettings : team_settings_and_inventory_device = team_settings_and_inventory_device{}
    #Start using a cue instead for SFXOne and Two. 
    @editable
    CruiseMissleSFXOne : audio_player_device = audio_player_device{}
    @editable
    CruiseMissleSFXTwo : audio_player_device = audio_player_device{}
    @editable
    CruiseMissleBlastSFX : audio_player_device = audio_player_device{}
    @editable 
    CruiseMissleBlastVFX : vfx_spawner_device = vfx_spawner_device{}
    @editable
    CruiseMissleBlastLocation : creative_prop = creative_prop{}
    @editable
    TurretGunProp : creative_prop = creative_prop{}
    @editable
    MirrorProp : creative_prop = creative_prop{}
    @editable
    SentryGun : creative_prop = creative_prop{}
    @editable
    var elibilityLvlOne : int = 0
    @editable
    var elibilityLvlTwo : int = 0
    @editable
    var elibilityLvlThree : int = 0
    @editable
    var elibilityLvlFour : int = 0
    @editable
    var elibilityLvlFive : int = 0
    @editable
    CreativePropInst : creative_prop = creative_prop{}
    #In the future, make this so there is more than one that is declared if there are more players. This is a struct
    #initialPlayerPosition : vector3 = vector3{}
    #Get the intitial player position and then whatever is ++ or -- will contribute to how much the camera should move in x,y,z. Inital at x - camera position at x. 

    OnBegin<override>()<suspends>:void=
        #var characterRotX : float := CharacterRotation.X
        #KillStreakClassInstance := killstreak_device_class{}
        #Button.InteractedWithEvent.Subscribe(MissileLoad)
        Button.InteractedWithEvent.Subscribe(InitializePlayerCameraTest)
        TeamSettings.TeamMemberEliminatedEvent.Subscribe(RespawnSequence)
    #This loop will start when the function is called. Will continue looping until the cinematic is over. When cinematic is over, spawn at the final location explosive devices and detitnate. 
    InitializeKillstreak(Agent: agent) : void = 
        Print("Load cruise missile kilstreak.")
        ##Cine Missile Test
        LoadGuardianKillstreak(Agent)
    InitializePlayerCameraTest(Agent : agent) : void =
        spawn {PlayerCameraTesting(Agent)}
    MissleKillstreak(Player: agent)<suspends> : void =
        CruiseMissleBlastVFX.Disable()
        #I want to test out player rotation and see if it's actually locked or not.
        Print("DEBUG: Missle Killstreak Activated!")
        CruiseExplosive.TurnOffVisibility()
        var CharacterPosition : vector3 = vector3{}
        var CharacterPositionSP : vector3 = vector3{}
        var missleXCord : float = CharacterPosition.X
        var missleYCord : float = CharacterPosition.Y
        #var character_args : stasis_args = stasis_args{AllowTurning := false}
        #Look at CharacterPosition Z value and calculate ground from there. Figure out where Z starts and where Z ends.
        var missleZCord : float = 30000.0
        var iteration : int = 1
        Players_test: []agent := Self.GetPlayspace().GetPlayers()
        for (Char -> Index : Players_test):
            if (FortChar := Players_test[Char].GetFortCharacter[]):
                set CharacterPositionSP = FortChar.GetTransform().Translation
                FortChar.SetVisible(false)
                #FortChar.PutInStasis(character_args)
        #I don't like this loop doing a for loop every increment. I'll optimize this during a code review with Epic staff.
        loop:
            set missleZCord -= 1.0 * iteration
            set iteration += 1
            Players: []agent := Self.GetPlayspace().GetPlayers()
                for (Char -> Index : Players):
                    if (FortChar := Players[Char].GetFortCharacter[]):
                        set CharacterPosition = FortChar.GetTransform().Translation
            CreativePropInst.MoveTo(vector3{X := CharacterPosition.X, Y:=CharacterPosition.Y, Z:= missleZCord}, IdentityRotation(), 0.01)
            Sleep(0.02)
            #Whatever the character's Z position is, break out of loop and move blast location there.
            if (missleZCord <= CharacterPosition.Z):
                Print("DEBUG: ")
                CruiseMissleBlastLocation.MoveTo(vector3{X := CharacterPosition.X, Y:=CharacterPosition.Y, Z:= missleZCord}, IdentityRotation(), 0.01)
                break
        #Have explosive not affect instigator. 
        for (Char -> Index : Players_test):
            if (FortChar := Players_test[Char].GetFortCharacter[]):
                FortChar.SetVisible(true)       
        MissileUnload(Player)
        set missleZCord = 30000.0

    MissileUnload(Player : agent) : void =
        CineMissle.Stop()
        CruiseMissleBlastVFX.Enable()
        CruiseMissleBlastSFX.Play()
        CruiseExplosive.Explode(Player)
        CruiseExplosive.Reset()
    
    MissileLoad(Player : agent) : void =
        CineMissle.Play()
        HUDControl.Enable()
        CruiseMissleSFXOne.Play()
        CruiseMissleSFXTwo.Play()
        spawn {MissleKillstreak(Player)}
    
    SentryGunKillStreak(Player: agent)<suspends> : void =
        #This is really hard to implement, I need to get the math right. I'll work on this another time.
        var CharacterPosition : vector3 = vector3{}
        var TurretGunPropPosition : vector3 = TurretGunProp.GetTransform().Translation
        var sentryRotX : vector3 = vector3{}
        var tempX : float = 0.0
        var tempY : float = 0.0
        var tempZ : float = 0.0
        loop:
            #If player enters mutator zone, begin function loop. Once exit, exit loop and function.
            #Z control left and right. Negative Z is Right and positive Z is Left. 
            Print("Y {tempY}")
            set tempY += 1.0
            if (tempY = 200.0):
                break
            Players: []agent := Self.GetPlayspace().GetPlayers()
                for (Char -> Index : Players):
                    if (FortChar := Players[Char].GetFortCharacter[]):
                        set CharacterPosition = FortChar.GetTransform().Translation
            TurretGunProp.MoveTo(TurretGunPropPosition, MakeRotation(vector3{X := 0.0, Y := 0.0, Z := -tempY}, 2.0), 0.02)
            Sleep(0.02)
    

    LoadGuardianKillstreak(Player: agent) : void = 
        spawn {GuardianKillStreak(Player)}

    GuardianKillStreak(Player: agent)<suspends> : void =
        Print("DEBUG: GuardianKillStreak Ran")
        var GuardianProp : vector3 = SentryGun.GetTransform().Translation
        var CharacterPosition : vector3 = vector3{}
        var selectPosition : logic = false 
        #Might have to move this loop after GetPlayspace GetPlayers.
        loop: 
            Players: []agent := Self.GetPlayspace().GetPlayers()
                for (Char -> Index : Players):
                    if (FortChar := Players[Char].GetFortCharacter[]):
                        set CharacterPosition = FortChar.GetTransform().Translation
            TurretGunProp.MoveTo(vector3{X := CharacterPosition.X + 10.0, Y:=CharacterPosition.Y + 10.0, Z:= CharacterPosition.Z}, IdentityRotation(), 0.02)
            if (selectPosition = true):
                break
            Sleep(0.02)
    RespawnSequence(Agent: agent) : void=
        CineRespawnSequence.Play()
    TestSequence(Agent: agent) : void=
        CineSeqTesting.Play()
    PlayerCameraTesting(Agent: agent)<suspends> : void=
        var CameraPosition : rotation = rotation{}
        var PropPosition : vector3 = vector3{}
        var moveYawTest : float = 0.0
        TestSequence(Agent)
        Players: []agent := Self.GetPlayspace().GetPlayers()
        var RotationAngle : vector3 = vector3{}
        var RotationAngleInit: vector3 = vector3{}
        
        var RotationAxis : vector3 = CameraPosition.GetAxis()
        #Will later be renamed to senesitivity and editable property
        var UpDownPitchAngle : float = 0.00
        var LeftRightYawAngle : float = 0.00
        loop:
            for (Char -> Index : Players):
                if (FortChar := Players[Char].GetFortCharacter[]):
                    set RotationAngleInit = FortChar.GetViewRotation().GetAxis()
                    Sleep(0.00001)
                    set RotationAngle = FortChar.GetViewRotation().GetAxis()
                    if (RotationAngleInit.Z > RotationAngle.Z):
                        if (RotationAngleInit.X > RotationAngle.X):
                            Print("Move left?")
                            #Move Left?
                            set LeftRightYawAngle += 0.1
                            MirrorProp.MoveTo(vector3{X := 0.0, Y:= 0.0, Z := 0.0}, IdentityRotation().ApplyYaw(LeftRightYawAngle), 0.0001)
                        else if (RotationAngleInit.X < RotationAngle.X):
                            #Move Right?
                            Print("Move right?")
                            set LeftRightYawAngle += 0.1
                            MirrorProp.MoveTo(vector3{X := 0.0, Y:= 0.0, Z := 0.0}, IdentityRotation().ApplyYaw(LeftRightYawAngle), 0.0001)
                        Print("Aiming up")
                        set UpDownPitchAngle += 0.1
                        MirrorProp.MoveTo(vector3{X := 0.0, Y:= 0.0, Z := 0.0}, IdentityRotation().ApplyPitch(UpDownPitchAngle), 0.0001)
                    else if (RotationAngleInit.Z < RotationAngle.Z):
                        #Add another if statement if moving left angle or right angle change
                        Print("Aiming down")
                        set UpDownPitchAngle -= 0.1
                        MirrorProp.MoveTo(vector3{X := 0.0, Y:= 0.0, Z := 0.0}, IdentityRotation().ApplyPitch(UpDownPitchAngle), 0.0001)
            Sleep(0.00)
        return
