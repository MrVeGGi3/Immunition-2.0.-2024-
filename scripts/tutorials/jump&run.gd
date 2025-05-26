extends Control

@onready var speech_tutorial = $SpeechTutorial
@onready var jump_tutorial = $JumpTutorial
@onready var player = get_tree().get_first_node_in_group("player")
var currentIndex = 0

@export_group("Variáveis de Localização")
@onready var  mov_title = "[font_size=40][b]" + tr("MOVIMENTATION_2_TITLE") + "[/b][/font_size]"
@onready var mov_tip_2 = "[font_size=30]" + tr("MOV_TIP_2") + "[/font_size]"
@onready var close_tutorial = "[color=gray][b]" + tr("PRESS_BUTTON_CLOSE_TUTORIAL") + "[/b][/color]"

var texts = [
	mov_title,
	mov_tip_2,
	close_tutorial
]

func _ready() -> void:
	speech_tutorial.bbcode_text = texts[currentIndex]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start") and visible:
		nextSpeech()
	
	jump_tutorial.text = tr("SKIP_BUTTON")
	
	texts = [
		mov_title,
		mov_tip_2,
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
