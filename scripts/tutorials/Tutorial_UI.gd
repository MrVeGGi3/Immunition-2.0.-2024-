extends Control
@onready var speech_tutorial = $SpeechTutorial
@onready var jump_tutorial = $JumpTutorial

var dialog_output = []
var currentIndex = 0
@onready var pause_menu = $"../pause_menu"
@onready var main_bgm = $"../../MainBGM"
#Tutorial dos Patógenos
# Called when the node enters the scene tree for the first time.
func _ready():
	dialog_output.append("Tutorial - Influenza")
	dialog_output.append("Bom soldado, agora teremos de lidar com outros tipos de intrusos!")
	dialog_output.append("Esse cara amarelo na sua frente é o Vírus Influenza")
	dialog_output.append("Ele ao entrar em contato com outras células, acaba contaminando elas")
	dialog_output.append("Como no exemplo á seguir:")
	#Enviar sinal para o tutorial sair e mostrar a cena ocorrendo
	dialog_output.append("A célula infectada agora irá tentar te atacar")
	dialog_output.append("Para se defender, utilize a arma [color=green]Linfócito[/color]")
	#jogador atira e destrói a instância 
	dialog_output.append("Vixe! Parece que surgiu outros virús! Por causa da memória do vírus armazenado na célula")
	dialog_output.append("Aqui é só destruir com qualquer arma que já funciona")
	nextSpeech()

func showCurrentSpeech():
	speech_tutorial.bbcode_text = dialog_output[currentIndex]
func nextSpeech():
	currentIndex += 1
	if currentIndex < dialog_output.size():
		showCurrentSpeech()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("start"):
		nextSpeech()
		
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = true
		main_bgm.play()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		visible = false
	
func _on_voltar_ao_jogo_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	main_bgm.stop()
	visible = true 
	get_tree().paused = false
		
