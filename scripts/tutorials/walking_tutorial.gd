extends Control

@onready var speech_tutorial = $SpeechTutorial
@onready var jump_tutorial = $JumpTutorial
@onready var player = get_tree().get_first_node_in_group("player")
@onready var tutorial_walking_bar_2: Control = $"../TutorialWalkingBar2"

var currentIndex = 0
var move_up = false
var move_down = false
var move_left = false
var move_right = false
var moved = false
var secondary = true


@export_group("Variáveis de Localização")
@onready var tutorial = "[center][b][font_size=50]" + tr("TUTORIAL_TITLE") + "[/font_size][/b][/center]"
@onready var tutorial_speech_1 = "[font_size=30]" + tr("TUTORIAL_SPEECH_1") + "[/font_size]"
@onready var tutorial_speech_2 = tr("TUTORIAL_SPEECH_2")
@onready var tutorial_speech_3 = tr("TUTORIAL_SPEECH_3")
@onready var tutorial_speech_4 = tr("TUTORIAL_SPEECH_4")
@onready var tutorial_speech_5 = tr("TUTORIAL_SPEECH_5")
@onready var movimentation = "[b][font_size=40]" +  tr("MOVIMENTATION_TITLE") + "[/font_size][/b]"
@onready var tutorial_tip_1 = "[font_size=30]" + tr("TUTORIAL_TIP_1") + "[/font_size]"
@onready var tutorial_speech_6 = tr("TUTORIAL_SPEECH_6")
@onready var close_tutorial = "[color=gray]" + tr("PRESS_BUTTON_CLOSE_TUTORIAL") + "[/color]"

@onready var texts = [
	tutorial, tutorial_speech_1, tutorial_speech_2, tutorial_speech_3,
	tutorial_speech_4, tutorial_speech_5, movimentation, tutorial_tip_1,
	tutorial_speech_6, close_tutorial 
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speech_tutorial.bbcode_text = texts[currentIndex]


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
		
	texts = [
		tutorial,
		tutorial_speech_1,
		tutorial_speech_2,
		tutorial_speech_3,
		tutorial_speech_4,
		tutorial_speech_5,
		movimentation,
		tutorial_tip_1,
		tutorial_speech_6,
		close_tutorial
	]
	
	jump_tutorial.text = tr("SKIP_BUTTON")

func _on_jump_tutorial_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	visible = false
	get_tree().paused = false
	player.restore_UI()
	
func nextSpeech():
	currentIndex += 1
	if currentIndex < texts.size():
		showCurrentSpeech()

func showCurrentSpeech():
	speech_tutorial.bbcode_text = texts[currentIndex]

func second_dialogue():
	secondary = false
	player.disable_UI()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	tutorial_walking_bar_2.visible = true

func get_moved_variable():
	return moved
