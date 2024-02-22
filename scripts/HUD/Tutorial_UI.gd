extends Control
@onready var speech_tutorial = $SpeechTutorial
@onready var jump_tutorial = $JumpTutorial

var dialog_output = []
var currentIndex = 0
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
	dialog_output.append("Pressionando [b]Shift[b] a velocidade é aumentada!")
	dialog_output.append("[b]Atirar:[/b]")
	dialog_output.append("Rotação com o movimento do mouse, atirar com o botão esquerdo")
	dialog_output.append("[b]Mecânica[/b]:")
	dialog_output.append("Está vendo esse patógeno que está indo em sua direção?")
	dialog_output.append("Observe a [color=green] cor[/color] dele..Esse daqui parece não estar muito maduro né?")
	dialog_output.append("Cada [color=green]cor[/color] no seu [color=green]quadrado[/color], ou melhor, com sua [color=green] arma. [/color]")
	dialog_output.append("Para eliminar esse daqui, só com os [color=green]Linfócitos[/color]!")
	dialog_output.append("O mesmo vale para os outros invasores.")
	dialog_output.append("Os azuis com os [color=blue]macrófagos.[/color]")
	dialog_output.append("Os vermelhos com os [color=red] neutrófilos.[/color]")
	dialog_output.append("Para trocar de arma, basta apenas pressionar [color=green]1[/color],[color=blue]2[/color],[color=red] 3[/color].")
	dialog_output.append("Bom soldado, creio que está preparado!")
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
