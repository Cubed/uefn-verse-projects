using { /Fortnite.com/Devices }
using { /Fortnite.com/UI }
using { /Verse.org/Native }
using { /Verse.org/Simulation}
using { /EpicGames.com/Temporary/Diagnostics }
using { /EpicGames.com/Temporary/UI}
using { /EpicGames.com/Temporary/SpatialMath }
using { /Verse.org/Random }
using { /Verse.org/Verse }
using { /Fortnite.com/Characters }
#TODO: Create a class that will eventually let you set a password. Then the person has to input the password you have set.
#In the future, we will have it so it's connected to persistance.

#There is currently an issue when clicking Cancel first for the canvas. I'll look into this later and ask around. Also, using string comparisons are not working.


projectn_main := class<concrete>(creative_device):
    @editable
    ProjectNAudioPlayer:audio_player_device = audio_player_device{}
    @editable
    var Button : button_device = button_device{}
    @editable
    Explosion : explosive_device = explosive_device{}


    #Variables
    var Canvas :? canvas = false
    var attempts : int = 0
    var globalString : string = ""
    var passAttemptSuccess : logic = false
    var password : string = "123"

    #Not Yet Implemented
    @editable
    var numIncorrectAttemptsLimit : int = 0
    @editable
    var accountName : string = ""
    @editable
    var accountPassword : string = ""


    #Widgets
    ConfirmButton: button_loud = button_loud { DefaultText := "Confirm" }
    EditBox: editable_text_box = editable_text_box{ DefaultText := "Enter Text Here" }
    CancelButton: button_regular = button_regular { DefaultText := "Cancel" }

    OnBegin<override>()<suspends>:void = {
        
        Button.InteractedWithEvent.Subscribe(PromptUserInput)
        #ConfirmButton.OnClick.Subscribe(OnTextConfirmed)
        #CancelButton.OnClick.Subscribe(CancelButtonEvent)
    }

    PromptUserInput(Player:player) : void = {
        if (PlayerUI := GetPlayerUI[Player]) {
            if (ExistingCanvas := Canvas?) {
                PlayerUI.RemoveWidget(ExistingCanvas)
                set Canvas = false
            }
            else 
            {
                DisplayCanvas := CreateCanvas()
                PlayerUI.AddWidget(DisplayCanvas, player_ui_slot{ InputMode := ui_input_mode.All })
                set Canvas = option{DisplayCanvas}
            }
        }

    }


    CreateCanvas() : canvas = { 
        Print("DEBUG: CANVAS CREATED")
        ConfirmButton.OnClick.Subscribe(OnTextConfirmed)
        CancelButton.OnClick.Subscribe(CancelButtonEvent)
        CanvasTextBlock := canvas:
            Slots:= array:
                canvas_slot: 
                    Anchors := anchors{ Maximum:= vector2{X:=1.0, Y:=1.0} }
                    Offsets := margin{ Top:=100.0, Left:= 1200.0, Right:=700.0, Bottom := 100.0 }
                    Widget := stack_box:
                        Orientation := orientation.Horizontal
                        Slots := array:
                            stack_box_slot:
                                HorizontalAlignment := horizontal_alignment.Left
                                VerticalAlignment := vertical_alignment.Top
                                Widget := EditBox
                            stack_box_slot:
                                HorizontalAlignment := horizontal_alignment.Left
                                VerticalAlignment := vertical_alignment.Top
                                Widget := ConfirmButton
                            stack_box_slot:
                                HorizontalAlignment := horizontal_alignment.Left
                                VerticalAlignment := vertical_alignment.Top
                                Widget := CancelButton
        return CanvasTextBlock
    
    }
    
    OnTextConfirmed(WidgetMessage: widget_message) : void = {
        Print("DEBUG: ON TEXT CONFIRMED RAN")
        set globalString = EditBox.GetText()
        AttemptPassword(WidgetMessage.Player)
    }                         

    AttemptPassword(Player:player) : void = {
        Print("DEBUG: Password entered is: {globalString}")
        Print("DEBUG: Input expects: {password}")
        if (globalString = password) 
        {
            Print("You entered in the correct password!")
            Explosion.Explode(Player)
            #Teleport user to custom island.
        }
        else if (globalString <> password) {
            Print("You entered in the wrong password! Try again!")
        }
        else {
            Print("We reached the else statement. This shouldn't happen")
        }
    }

    PasswordGenerate()<decides> : void = {
        Print("DEBUG: Password Generate ran")
        ExampleArray : []char =  {
            "abcdefghijklmnopqrstuvwxyz"
        }
        var modulas : int = Mod[GetRandomInt(0,26), 26]
        var charString : char = ExampleArray[modulas]
        Print("{charString}")
    }

    RemoveCanvas(Player:player): void = {
    Print("DEBUG: CANVAS REMOVE FUNCTION RAN.")
        if (PlayerUI := GetPlayerUI[Player]) {
            if (ExistingCanvas := Canvas?) {
                   PlayerUI.RemoveWidget(ExistingCanvas)
                   set Canvas = false
               }
           }
    }
    
    CancelButtonEvent(WidgetMessage: widget_message) : void = {
        Print("DEBUG: CANCEL BUTTON EVENT RAN")
        RemoveCanvas(WidgetMessage.Player)
    }
