extends Control
@onready var speech_tutorial = $SpeechTutorial
@onready var jump_tutorial = $JumpTutorial

var dialog_output = []
var currentIndex = 0
@onready var pause_menu = $"../pause_menu"
@onready var main_bgm = $"../../MainBGM"

# Called when the node enters the scene tree for the first time.
func _ready():
	dialog_output.append("Tutorial")
	dialog_output.append("Bem vindo á medula óssea, soldado!")
	dialog_output.append("Bom, temos muito trabalho por aqui...")
	dialog_output.append("Acabou havendo um corte simples no braço.")
	dialog_output.append("E por fim, algums invasores entraram...")
	dialog_output.append("Vamos te ensinar como lidar com esses enxeridos!")
	dialog_output.append("[b]Movimentação:[/b]")
	dialog_output.append("W, A, S, D para andar e o botão [b]Espaço[/b] para pular")
	dialog_output.append("[b]Atirar:[/b]")
	dialog_output.append("Rotação com o movimento do mouse, atirar com o botão esquerdo")
	dialog_output.append("[b]Mecânica[/b]:")
	dialog_output.append("Está vendo esse patógeno que está indo em sua direção?")
	dialog_output.append("Cada [color=green]cor[/color] no seu [color=green]quadrado[/color]")
	dialog_output.append("Para usar o sistema de memória, basta pressionar [b] E [/b/] e selecionar com o mouse")
	dialog_output.append("A memória com a mesma cor do patógeno causa maior efeito e dano")
	dialog_output.append("Para selecionar alguma arma, basta pressionar o botão [b] Q [/b] e usar o mouse")
	dialog_output.append("Ou usar [color=green][b] 1 [/b][/color], [color=blue][b] 2 [/b][/color ,[color=red][b] 3 [/b][/color para alterar rapidamente")
	dialog_output.append(("[b] Efeitos de Armas[/b]"))
	dialog_output.append("A arma [color=green] Linfócito [/color] causa menor dano, e lentidão")
	dialog_output.append("A arma [color=blue] Macrófago [/color] causa maior dano instantâneo e tem maior alcance")
	dialog_output.append("A arma[color=red] Neutrófilo[/color] causa maior dano contínuo e em área")
	dialog_output.append("Bom soldado, creio que está preparado para a guerra!")
	dialog_output.append("Vá com sede de sangue! Ops.. não desse corpo, quis dizer.. você entendeu...")
	dialog_output.append("[color=gray](Pressione o botão abaixo para encerrar o tutorial)[/color]")
	speech_tutorial.bbcode_text = dialog_output[currentIndex]
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