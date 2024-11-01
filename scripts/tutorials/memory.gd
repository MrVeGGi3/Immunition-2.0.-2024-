extends Control

@onready var speech_tutorial = $SpeechTutorial
@onready var jump_tutorial = $JumpTutorial
@onready var player = get_tree().get_first_node_in_group("player")
var dialog_output = []
var currentIndex = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialog_output.append("[font_size=40] Sistema de Memória [/font_size]")
	dialog_output.append("Está vendo esse patógeno que está indo em sua direção?")
	dialog_output.append("Cada [color=green] cor [/color] no seu [color=green] quadrado[/color].")
	dialog_output.append("Para usar o sistema de memória, basta pressionar [b] E [/b] [p] e selecionar com o [b] Mouse [/b] [/p]")
	dialog_output.append("[font_size=25] A memória com a mesma [color=purple] cor/símbolo [/color] do [color=purple] patógeno [/color] [p] causa maior efeito e dano [/p]")
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
	
	visible = false
	get_tree().paused = false
	player.restore_UI()
