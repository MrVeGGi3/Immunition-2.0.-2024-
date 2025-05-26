extends Control

@onready var speech_tutorial = $SpeechTutorial
@onready var jump_tutorial = $JumpTutorial
@onready var player = get_tree().get_first_node_in_group("player")
var currentIndex = 0


@export_group("Variáveis de Localização")
@onready var memory_system_title = "[font_size=40]" + tr("MEMORY_SYSTEM_TITLE") + "[/font_size]"
@onready var memory_system_tip = tr("MEMORY_SYSTEM_TIP")
@onready var memory_system_tip_2 = tr("MEMORY_SYSTEM_TIP_2")
@onready var memory_system_tip_3 = tr("MEMORY_SYSTEM_TIP_3")
@onready var memory_system_tip_4 = "[font_size=25]" + tr("MEMORY_SYSTEM_TIP_4") + "[/font_size]"
@onready var close_tutorial = "[color=gray]" + tr("BACK_BUTTON") + "[/color]"

@onready var texts = [
	memory_system_title,
	memory_system_tip,
	memory_system_tip_2,
	memory_system_tip_3,
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
	
	texts = [
	memory_system_title,
	memory_system_tip,
	memory_system_tip_2,
	memory_system_tip_3,
	close_tutorial
]
	

func showCurrentSpeech():
	speech_tutorial.bbcode_text = texts[currentIndex]
func nextSpeech():
	currentIndex += 1
	if currentIndex < texts.size():
		showCurrentSpeech()
		
func _on_jump_tutorial_pressed():
	
	visible = false
	get_tree().paused = false
	player.restore_UI()
