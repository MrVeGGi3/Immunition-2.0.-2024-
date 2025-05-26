extends Control

@onready var speech_tutorial = $SpeechTutorial
@onready var jump_tutorial = $JumpTutorial
@onready var player = get_tree().get_first_node_in_group("player")
var currentIndex = 0

@export_group("Variáveis de Localização")
@onready var end_game_title = "[font_size=40]" + tr("END_GAME_TITLE") + "[/font_size]"
@onready var end_game_tip  = tr("END_GAME_TIP")
@onready var end_game_tip_2 = tr("END_GAME_TIP_2")
@onready var end_game_tip_3 = tr("END_GAME_TIP_3")
@onready var end_game_tip_4 = tr("END_GAME_TIP_4")
@onready var end_game_order = tr("END_GAME_ORDER")
@onready var close_tutorial = "[color=gray]" + tr("PRESS_BUTTON_CLOSE_TUTORIAL") + "[/color]"

@onready var texts = [
	end_game_title, end_game_tip,
	end_game_tip_2, end_game_tip_3,
	end_game_tip_4, end_game_order,
	close_tutorial
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speech_tutorial.bbcode_text = texts[currentIndex]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start") and visible:
		nextSpeech()
		
	jump_tutorial.text = tr("SKIP_BUTTON")
	
	var texts = [
	end_game_title, end_game_tip,
	end_game_tip_2, end_game_tip_3,
	end_game_tip_4, end_game_order,
	close_tutorial
]

func showCurrentSpeech():
	speech_tutorial.bbcode_text = texts[currentIndex]
	
func nextSpeech():
	currentIndex += 1
	if currentIndex < texts.size():
		showCurrentSpeech()
		
func _on_jump_tutorial_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	visible = false
	get_tree().paused = false
	player.restore_UI()
