extends Control

@onready var speech_tutorial = $SpeechTutorial
@onready var jump_tutorial = $JumpTutorial
@onready var player = get_tree().get_first_node_in_group("player")
var currentIndex = 0
var move_up = false
var move_down = false
var move_left = false
var move_right = false
var moved = false

@export_group("Variáveis de Localização")
@onready var shoot_title ="[b] [font_size=40]" +  tr("SHOOT_TITLE") + "[/font_size] [/b]"
@onready var tutorial_tip_2 ="[font_size=30]" +  tr("TUTORIAL_TIP_2") + "[/font_size]"
@onready var tutorial_speech = tr("TUTORIAL_SPEECH_7")
@onready var close_tutorial = "[color=gray]"  + tr("PRESS_BUTTON_CLOSE_TUTORIAL") +  "[/color]"

@onready var texts = [shoot_title, tutorial_tip_2, tutorial_speech, close_tutorial]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	speech_tutorial.bbcode_text = texts[currentIndex]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("start") and visible:
		nextSpeech()
		
	texts = [
		shoot_title,
		tutorial_tip_2,
		tutorial_speech,
		close_tutorial
	]
	
	jump_tutorial.text = ("SKIP_BUTTON")
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
