# using { /Fortnite.com/Devices }
# using { /Fortnite.com/UI }
# using { /Verse.org/Native }
# using { /Verse.org/Simulation}
# using { /EpicGames.com/Temporary/Diagnostics }
# using { /EpicGames.com/Temporary/UI}
# using { /EpicGames.com/Temporary/SpatialMath }





# killstreak_device_class := class<concrete>(killstreak_device):
#     killStreakSequenceBegin(Player: player) : void = {
#         set killAmount += 1
#         Print("DEBUG: KillStreakSequenceBegin called.")
#         Print("Kill amount is {killAmount}")
#         setLevelEligibility(Player)
#     }
#     rewardKillStreakLVLOne() : void = {
#         Print("DEBUG: LEVEL ONE: Reward Sending care package.")
#     }
#     rewardKillStreakLVLTwo() : void = {
#         Print("DEBUG: LEVEL TWO: Reward Sending UAV")
#     }
#     rewardKillStreakLVLThree() : void = {
#         Print("DEBUG: LEVEL THREE: Sending PH")
#     }
#     rewardKillStreakLVLFour() : void = {
#         Print("DEBUG: LEVEL FOUR: Sending PH")
#     }
#     rewardKillStreakLVLFive() : void = {
#         Print("DEBUG: LEVEL FIVE: Sending PH")
#     }
#     setLevelEligibility(Player:player): void = {
#     Print("DEBUG: setLevelEligibility called.")    
#     if (PlayerUI := GetPlayerUI[Player]):
#         Print("DEBUG: GetPlayerUI called")
#         if (ExistingCanvas := Canvas?):
#             Print("DEBUG: ExistingCanvas? called")
#             PlayerUI.RemoveWidget(ExistingCanvas)
#             set Canvas = false 
#             Print("DEBUG: killAmount is {killAmount} in setLevelEligibility case")
#             case (killAmount):
#                 2 =>
#                     Print("Attempting to create NewCanvas (2) kills")
#                     NewCanvas := killStreakLVLOne()
#                     PlayerUI.AddWidget(NewCanvas, player_ui_slot{ InputMode := ui_input_mode.None })
#                     set Canvas = option{NewCanvas}
#                     rewardKillStreakLVLOne()
#                 4 =>
#                     Print("Attempting to create NewCanvas (4) kills")
#                     NewCanvas := killStreakLVLTwo()
#                     PlayerUI.AddWidget(NewCanvas, player_ui_slot{ InputMode := ui_input_mode.None })
#                     set Canvas = option{NewCanvas}
#                     rewardKillStreakLVLTwo()
#                 6 =>
#                     Print("Attempting to create NewCanvas (6) kills")
#                     NewCanvas := killStreakLVLThree()
#                     PlayerUI.AddWidget(NewCanvas, player_ui_slot{ InputMode := ui_input_mode.None })
#                     set Canvas = option{NewCanvas}
#                     rewardKillStreakLVLThree()
#                 10 =>
#                     Print("Attempting to create NewCanvas (10) kills")
#                     NewCanvas := killStreakLVLFour()
#                     PlayerUI.AddWidget(NewCanvas, player_ui_slot{ InputMode := ui_input_mode.None })
#                     set Canvas = option{NewCanvas}
#                     rewardKillStreakLVLFour()
#                 12 =>
#                     Print("Attempting to create NewCanvas (12) kills")
#                     NewCanvas := killStreakLVLFive()
#                     PlayerUI.AddWidget(NewCanvas, player_ui_slot{ InputMode := ui_input_mode.None })
#                     set Canvas = option{NewCanvas}
#                     rewardKillStreakLVLFive()                       
#                 _ =>
#                     NewCanvas := killStreakLVLInit()
#                     PlayerUI.AddWidget(NewCanvas, player_ui_slot{ InputMode := ui_input_mode.None })
#                     set Canvas = option{NewCanvas}
#         else:
#             Print("An error has occurred.")
#             case (killAmount):
#                 2 =>
#                     Print("Attempting to create NewCanvas (2) kills")
#                     NewCanvas := killStreakLVLOne()
#                     PlayerUI.AddWidget(NewCanvas, player_ui_slot{ InputMode := ui_input_mode.None })
#                     set Canvas = option{NewCanvas}
#                     rewardKillStreakLVLOne()
#                 4 =>
#                     Print("Attempting to create NewCanvas (4) kills")
#                     NewCanvas := killStreakLVLTwo()
#                     PlayerUI.AddWidget(NewCanvas, player_ui_slot{ InputMode := ui_input_mode.None })
#                     set Canvas = option{NewCanvas}
#                     rewardKillStreakLVLTwo()
#                 6 =>
#                     Print("Attempting to create NewCanvas (6) kills")
#                     NewCanvas := killStreakLVLThree()
#                     PlayerUI.AddWidget(NewCanvas, player_ui_slot{ InputMode := ui_input_mode.None })
#                     set Canvas = option{NewCanvas}
#                     rewardKillStreakLVLThree()
#                 10 =>
#                     Print("Attempting to create NewCanvas (10) kills")
#                     NewCanvas := killStreakLVLFour()
#                     PlayerUI.AddWidget(NewCanvas, player_ui_slot{ InputMode := ui_input_mode.None })
#                     set Canvas = option{NewCanvas}
#                     rewardKillStreakLVLFour()
#                 12 =>
#                     Print("Attempting to create NewCanvas (12) kills")
#                     NewCanvas := killStreakLVLFive()
#                     PlayerUI.AddWidget(NewCanvas, player_ui_slot{ InputMode := ui_input_mode.None })
#                     set Canvas = option{NewCanvas}
#                     rewardKillStreakLVLFive()                       
#                 _ =>
#                     NewCanvas := killStreakLVLInit()
#                     PlayerUI.AddWidget(NewCanvas, player_ui_slot{ InputMode := ui_input_mode.None })
#                     set Canvas = option{NewCanvas}
                


#     }
    
#     killStreakLVLInit():canvas = {
#         WantedLevel:text_block= text_block { DefaultText := "{lvlOneKillEligibility - killAmount} kill(s) left to unlock UAV ✈" }
#         YouAreWanted:text_block = text_block { DefaultText := "KILLSTREAK:"}
#         KillStreakSlotOne:text_block = text_block { DefaultText := "[✈]"}
#         KillStreakSlotTwo:text_block = text_block { DefaultText := "[💣]"}
#         KillStreakSlotThree:text_block = text_block { DefaultText := "[🔭]"}
#         NewCanvas := canvas:
#             Slots := array:
#                 canvas_slot:
#                     Anchors := anchors{ Maximum:= vector2{X:=1.0, Y:=1.0} }
#                     Offsets := margin{ Top:=100.0, Left:= 200.0, Right:=1700.0, Bottom := 100.0 }
#                     Widget := stack_box:
#                         Orientation := orientation.Horizontal
#                         Slots := array:
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Right
#                                 VerticalAlignment := vertical_alignment.Top
#                                 Widget := YouAreWanted
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Left
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := WantedLevel
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Center
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := KillStreakSlotOne
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Right
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := KillStreakSlotTwo
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Left
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := KillStreakSlotThree
#         return NewCanvas
#     }
#     killStreakLVLOne():canvas = {
#         WantedLevel:text_block= text_block { DefaultText := "{lvlTwoKillEligibility - killAmount} kill(s) left to unlock PH 💣" }
#         YouAreWanted:text_block = text_block { DefaultText := "KILLSTREAK:"}
#         KillStreakSlotOne:text_block = text_block { DefaultText := "[✈]✅"}
#         KillStreakSlotTwo:text_block = text_block { DefaultText := "[💣]"}
#         KillStreakSlotThree:text_block = text_block { DefaultText := "[🔭]"}
#         NewCanvas := canvas:
#             Slots := array:
#                 canvas_slot:
#                     Anchors := anchors{ Maximum:= vector2{X:=1.0, Y:=1.0} }
#                     Offsets := margin{ Top:=100.0, Left:= 200.0, Right:=1700.0, Bottom := 100.0 }
#                     Widget := stack_box:
#                         Orientation := orientation.Horizontal
#                         Slots := array:
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Left
#                                 VerticalAlignment := vertical_alignment.Top
#                                 Widget := YouAreWanted
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Left
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := WantedLevel
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Left
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := KillStreakSlotOne
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Left
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := KillStreakSlotTwo
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Left
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := KillStreakSlotThree
#         return NewCanvas
#     }
#     killStreakLVLTwo():canvas = {
#         WantedLevel:text_block= text_block { DefaultText := "{lvlThreeKillEligibility - killAmount} kill(s) left to unlock UAV ✈" }
#         YouAreWanted:text_block = text_block { DefaultText := "KILLSTREAK:"}
#         KillStreakSlotOne:text_block = text_block { DefaultText := "[✈]✅"}
#         KillStreakSlotTwo:text_block = text_block { DefaultText := "[💣]✅"}
#         KillStreakSlotThree:text_block = text_block { DefaultText := "[🔭]"}
#         NewCanvas := canvas:
#             Slots := array:
#                 canvas_slot:
#                     Anchors := anchors{ Maximum:= vector2{X:=1.0, Y:=1.0} }
#                     Offsets := margin{ Top:=100.0, Left:= 200.0, Right:=1700.0, Bottom := 100.0 }
#                     Widget := stack_box:
#                         Orientation := orientation.Horizontal
#                         Slots := array:
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Center
#                                 VerticalAlignment := vertical_alignment.Top
#                                 Widget := YouAreWanted
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Center
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := WantedLevel
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Center
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := KillStreakSlotOne
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Center
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := KillStreakSlotTwo
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Center
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := KillStreakSlotThree
#         return NewCanvas
#     }
#     killStreakLVLThree():canvas = {
#         WantedLevel:text_block= text_block { DefaultText := "{lvlOneKillEligibility - killAmount} kill(s) left to unlock UAV ✈" }
#         YouAreWanted:text_block = text_block { DefaultText := "KILLSTREAK:"}
#         KillStreakSlotOne:text_block = text_block { DefaultText := "[✈]✅"}
#         KillStreakSlotTwo:text_block = text_block { DefaultText := "[💣]✅"}
#         KillStreakSlotThree:text_block = text_block { DefaultText := "[🔭]✅"}
#         NewCanvas := canvas:
#             Slots := array:
#                 canvas_slot:
#                     Anchors := anchors{ Maximum:= vector2{X:=1.0, Y:=1.0} }
#                     Offsets := margin{ Top:=100.0, Left:= 200.0, Right:=1700.0, Bottom := 100.0 }
#                     Widget := stack_box:
#                         Orientation := orientation.Horizontal
#                         Slots := array:
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Center
#                                 VerticalAlignment := vertical_alignment.Top
#                                 Widget := YouAreWanted
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Left
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := WantedLevel
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Left
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := KillStreakSlotOne
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Left
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := KillStreakSlotTwo
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Left
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := KillStreakSlotThree
#         return NewCanvas
#     }
#     killStreakLVLFour():canvas = {
#         WantedLevel:text_block= text_block { DefaultText := "{lvlOneKillEligibility - killAmount} kill(s) left to unlock UAV ✈" }
#         YouAreWanted:text_block = text_block { DefaultText := "KILLSTREAK:"}
#         KillStreakSlotOne:text_block = text_block { DefaultText := "[✈]"}
#         KillStreakSlotTwo:text_block = text_block { DefaultText := "[💣]"}
#         KillStreakSlotThree:text_block = text_block { DefaultText := "[🔭]"}
#         NewCanvas := canvas:
#             Slots := array:
#                 canvas_slot:
#                     Anchors := anchors{ Maximum:= vector2{X:=1.0, Y:=1.0} }
#                     Offsets := margin{ Top:=100.0, Left:= 200.0, Right:=1700.0, Bottom := 100.0 }
#                     Widget := stack_box:
#                         Orientation := orientation.Horizontal
#                         Slots := array:
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Right
#                                 VerticalAlignment := vertical_alignment.Top
#                                 Widget := YouAreWanted
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Left
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := WantedLevel
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Left
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := KillStreakSlotOne
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Left
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := KillStreakSlotTwo
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Left
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := KillStreakSlotThree
#         return NewCanvas
#     }
    
#     killStreakLVLFive():canvas = {
#         WantedLevel:text_block= text_block { DefaultText := "{lvlOneKillEligibility - killAmount} kill(s) left to unlock UAV ✈" }
#         YouAreWanted:text_block = text_block { DefaultText := "KILLSTREAK:"}
#         KillStreakSlotOne:text_block = text_block { DefaultText := "[✈]✅"}
#         KillStreakSlotTwo:text_block = text_block { DefaultText := "[💣]✅"}
#         KillStreakSlotThree:text_block = text_block { DefaultText := "[🔭]✅"}
#         NewCanvas := canvas:
#             Slots := array:
#                 canvas_slot:
#                     Anchors := anchors{ Maximum:= vector2{X:=1.0, Y:=1.0} }
#                     Offsets := margin{ Top:=100.0, Left:= 200.0, Right:=1700.0, Bottom := 100.0 }
#                     Widget := stack_box:
#                         Orientation := orientation.Horizontal
#                         Slots := array:
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Center
#                                 VerticalAlignment := vertical_alignment.Top
#                                 Widget := YouAreWanted
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Left
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := WantedLevel
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Left
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := KillStreakSlotOne
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Left
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := KillStreakSlotTwo
#                             stack_box_slot:
#                                 HorizontalAlignment := horizontal_alignment.Left
#                                 VerticalAlignment := vertical_alignment.Bottom
#                                 Widget := KillStreakSlotThree
#         return NewCanvas
#     }

    
#     var killAmount<public> : int = 0
#     var isEligibleLvl1 : logic = false
#     var isEligibleLvl2 : logic = false
#     var isEligibleLvl3 : logic = false
#     var isEligibleLvl4 : logic = false
#     var isEligibleLvl5 : logic = false
#     var lvlOneKillEligibility : int = 2
#     var lvlTwoKillEligibility : int = 4
#     var lvlThreeKillEligibility : int = 6
#     var lvlFourKillEligibility : int = 10
#     var lvlFiveKillEligibility : int = 12
