extends Control

@onready var speech_tutorial = $SpeechTutorial
@onready var jump_tutorial = $JumpTutorial
@onready var player = get_tree().get_first_node_in_group("player")
var dialog_output = []
var currentIndex = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialog_output.append("[font_size=40] Para o fim de jogo [/font_size]")
	dialog_output.append("Todo final de nível possui esse objeto na sua frente!")
	dialog_output.append("Para finalizar, basta apenas encostar nele!")
	dialog_output.append("Bom soldado, creio que está preparado para a guerra!")
	dialog_output.append("Vá com sede de sangue! [p] Ops.. não desse corpo, quis dizer.. você entendeu...[/p]")
	dialog_output.append("[color=purple] Vá para o objeto á frente para encerrar o tutorial [/color]")
	dialog_output.append("[color=gray](Pressione o botão abaixo para fechar o tutorial)[/color]")
	speech_tutorial.bbcode_text = dialog_output[currentIndex]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start") and visible:
		nextSpeech()

func showCurrentSpeech():
	speech_tutorial.bbcode_text = dialog_output[currentIndex]
	
func nextSpeech():
	currentIndex += 1
	if currentIndex < dialog_output.size():
		showCurrentSpeech()
		
func _on_jump_tutorial_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	visible = false
	get_tree().paused = false
	player.restore_UI()
