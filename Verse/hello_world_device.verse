
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /EpicGames.com/Temporary/UI}
using { /Fortnite.com/UI }
using {/EpicGames.com/Temporary/SpatialMath }
using {/Fortnite.com/Characters }
using { /Fortnite.com/Devices/CreativeAnimation }

#Create a widget that shows the killstreaks available.  


killstreak_device := class(creative_device):
    @editable
    Button : button_device = button_device{}
    @editable
    HUDControl : hud_controller_device = hud_controller_device{}
    @editable
    CineMissle : cinematic_sequence_device = cinematic_sequence_device{}
    @editable
    CruiseExplosive : explosive_device = explosive_device{}
    @editable
    CruiseMissleSFXOne : audio_player_device = audio_player_device{}
    @editable
    CruiseMissleSFXTwo : audio_player_device = audio_player_device{}
    @editable
    TurretGunProp : creative_prop = creative_prop{}
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
    #Get the intitial player position and then whatever is ++ or -- will contribute to how much the camera should move in x,y,z. Initiale at x - camera position at x. 


    OnBegin<override>()<suspends>:void=
        
        #var characterRotX : float := CharacterRotation.X
        #KillStreakClassInstance := killstreak_device_class{}
        Button.InteractedWithEvent.Subscribe(Temp)

    #This loop will start when the function is called. Will continue looping until the cinematic is over. When cinematic is over, spawn at the final location explosive devices and detitnate. 
    Temp(Player: player) : void = 
        Print("Running temp function on button press. Should start cine.")
        ##Cine Missile Test
        CineMissle.Play()
        HUDControl.Enable()
        CruiseMissleSFXOne.Activate()
        CruiseMissleSFXTwo.Activate()
        spawn {MissleKillstreak(Player)}
        spawn {SentryGunKillStreak(Player)}

    MissleKillstreak(Player: player)<suspends> : void =
        Print("DEBUG: Missle Killstreak Activated!")
        CruiseExplosive.TurnOffVisibility()
        var CharacterPosition : vector3 = vector3{}
        var missleXCord : float = CharacterPosition.X
        var missleYCord : float = CharacterPosition.Y
        #Look at CharacterPosition Z value and calculate ground from there. Figure out where Z starts and where Z ends.
        var missleZCord : float = 30000.0

        loop:
            set missleZCord -= 100.0
            Players: []player := Self.GetPlayspace().GetPlayers()
                for (Char -> Index : Players):
                    if (FortChar := Players[Char].GetFortCharacter[]):
                        set CharacterPosition = FortChar.GetTransform().Translation
            CreativePropInst.MoveTo(vector3{X := CharacterPosition.X - 1900.0, Y:=CharacterPosition.Y - 1900.0, Z:= missleZCord}, IdentityRotation(), 0.02)
            Sleep(0.02)
            if (missleZCord <= CharacterPosition.Z):
                Print("NIGHT NIGHT")
                break
        #Have explosive not affect instigator. 
        CineMissle.Stop()
        CreativePropInst.Dispose()
        CruiseExplosive.Explode(Player)
        CruiseExplosive.Reset()


    SentryGunKillStreak(Player: player)<suspends> : void =
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
            Players: []player := Self.GetPlayspace().GetPlayers()
                for (Char -> Index : Players):
                    if (FortChar := Players[Char].GetFortCharacter[]):
                        set CharacterPosition = FortChar.GetTransform().Translation
                TurretGunProp.MoveTo(TurretGunPropPosition, MakeRotation(vector3{X := 0.0, Y := 0.0, Z := -tempY}, 2.0), 0.02)
                Sleep(0.02)
            
            
                    

        
        
        
        