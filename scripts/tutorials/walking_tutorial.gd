extends Control

@onready var speech_tutorial = $SpeechTutorial
@onready var jump_tutorial = $JumpTutorial
@onready var player = get_tree().get_first_node_in_group("player")
@onready var tutorial_walking_bar_2: Control = $"../TutorialWalkingBar2"

var dialog_output = []
var dialog_output_2 = []
var currentIndex = 0
var move_up = false
var move_down = false
var move_left = false
var move_right = false
var moved = false
var secondary = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialog_output.append("[b] [center] [font_size=50] Tutorial [/font_size] [/center] [/b]")
	dialog_output.append("[font_size=30] Bem vindo á medula óssea, soldado![/font_size]")
	dialog_output.append("Bom, temos muito trabalho por aqui...")
	dialog_output.append("Acabou havendo um corte simples no braço.")
	dialog_output.append("E por fim, algums invasores entraram...")
	dialog_output.append("Vamos te ensinar como lidar com esses enxeridos!")
	dialog_output.append("[b] [font_size=40] Movimentação: [/font_size] [/b]")
	dialog_output.append("[font_size=30] W, A, S, D para andar [/font_size]")
	dialog_output.append("[font_size=30] Após se movimentar, espere o próximo passo [/font_size]")
	dialog_output.append("[color=gray](Pressione o botão abaixo para fechar o tutorial)[/color]")
	speech_tutorial.bbcode_text = dialog_output[currentIndex]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("start") and visible:
		nextSpeech()
	if Input.is_action_just_pressed("move_forwards") and !visible:
		move_up = true
	if Input.is_action_just_pressed("move_backwards") and !visible:
		move_down = true
	if Input.is_action_just_pressed("move_left") and !visible:
		move_left = true
	if Input.is_action_just_pressed("move_right") and !visible:
		move_right = true
	if move_down and move_up and move_left and move_right:
		moved = true
	
	if moved and secondary:
		second_dialogue()
		
		
	


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

func second_dialogue():
	secondary = false
	player.disable_UI()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	tutorial_walking_bar_2.visible = true


	
