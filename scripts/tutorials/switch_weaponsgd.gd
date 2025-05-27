extends Control

@onready var speech_tutorial = $SpeechTutorial
@onready var jump_tutorial = $JumpTutorial
var currentIndex = 0
@onready var player = get_tree().get_first_node_in_group("player")


@export_group("Variáveis de Localização")
@onready var weapon_selection = "[font_size=40]" + tr("WEAPON_SELECT_TITLE") + "[/font_size]"
@onready var weapon_selection_tip = "[font_size=20]" + tr("WEAPON_SELECT_TIP") + "[/font_size]"
@onready var weapon_selection_tip_2 = "[font_size=30] [b]" + tr("WEAPON_SELECT_TIP_2") + "[/b] [/font_size]"

@onready var weapons_selection_title = "[font_size=40] [b]" +  tr("WEAPON_EFFECTS_TITLE") + "[/b] [/font_size]"
@onready var weapon_effects_tip = "[font_size=30]" +  tr("WEAPON_EFFECTS_TIP") + "[/font_size]"
@onready var weapon_effects_tip_2  = "[font_size=25]" + tr("WEAPON_EFFECTS_TIP_2") + "[/font_size]"
@onready var weapon_effects_tip_3 = "[font_size=30]" + tr("WEAPON_EFFECTS_TIP_3") + "[/font_size]"
@onready var weapon_speech = "[font_size=30]" + tr("WEAPON_EFFECTS_SPEECH") + "[/font_size]"
@onready var weapon_speech_2 = "[font_size=30]" +  tr("W_EFFECTS_SPEECH_2") + "[/font_size]"
@onready var close_tutorial ="[color=gray]" + tr("PRESS_BUTTON_CLOSE_TUTORIAL") + "[/color]"

@onready var texts = [
	weapon_selection, weapon_selection_tip, weapon_selection_tip_2,
	weapons_selection_title, weapon_effects_tip, weapon_effects_tip_2,
	weapon_effects_tip_3, weapon_speech, weapon_speech_2, 
	close_tutorial
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speech_tutorial.bbcode_text = texts[currentIndex]
	
	texts = [
		weapon_selection,
		weapon_selection_tip,
		weapon_selection_tip_2,
		weapons_selection_title,
		weapon_effects_tip,
		weapon_effects_tip_2,
		weapon_effects_tip_3,
		weapon_speech,
		weapon_speech_2,
		close_tutorial	
	]
	
	jump_tutorial.text = tr("SKIP_BUTTON")
	
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start") and visible:
		nextSpeech()
