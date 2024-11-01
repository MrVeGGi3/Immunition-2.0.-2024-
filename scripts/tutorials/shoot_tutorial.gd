extends Control

@onready var speech_tutorial = $SpeechTutorial
@onready var jump_tutorial = $JumpTutorial
@onready var player = get_tree().get_first_node_in_group("player")
var dialog_output = []
var currentIndex = 0
var move_up = false
var move_down = false
var move_left = false
var move_right = false
var moved = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	dialog_output.append("[b] [font_size=40] Atirar: [/font_size] [/b]")
	dialog_output.append("[font_size=30] Rotação com o movimento do mouse, [p] atirar com o botão esquerdo [/p] [/font_size]")
	dialog_output.append("Após testar, vá para a plataforma á frente!")
	dialog_output.append("[color=gray](Pressione o botão abaixo para fechar o tutorial)[/color]")
	speech_tutorial.bbcode_text = dialog_output[currentIndex]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("start") and visible:
		nextSpeech()

func _on_jump_tutorial_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	visible = false
	get_tree().paused = false
	player.restore_UI()
	
func nextSpeech():
	currentIndex += 1
	if currentIndex < dialog_output.size():
		showCurrentSpeech()

func showCurrentSpeech():
	speech_tutorial.bbcode_text = dialog_output[currentIndex]
