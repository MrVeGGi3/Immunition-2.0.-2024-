extends Control

@onready var speech_tutorial = $SpeechTutorial
@onready var jump_tutorial = $JumpTutorial
var dialog_output = []
var currentIndex = 0
@onready var player = get_tree().get_first_node_in_group("player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialog_output.append("[font_size=40] Seleção de Armas [/font_size]")
	dialog_output.append("[font_size=30]  Para selecionar alguma arma, [p] basta pressionar o botão [b]Q[/b] e usar o [b] mouse [/b] [/p] [/font_size]")
	dialog_output.append("[font_size=30] Ou usar [color=green][b] 1 [/b][/color], [color=blue][b] 2 [/b][/color] ,[color=red][b] 3 [/b][/color] para alterar rapidamente [/font_size]")
	dialog_output.append(("[font_size=40][b] Efeitos de Armas [/b] [/font_size]"))
	dialog_output.append("[font_size=30] A arma [color=green] Linfócito [/color] causa menor dano, e lentidão [/font_size]")
	dialog_output.append("[font_size=25] A arma [color=blue] Macrófago [/color] causa maior dano instantâneo [p] e tem maior alcance [/p] [/font_size]")
	dialog_output.append("[font_size=30] A arma[color=red] Neutrófilo[/color] causa [p] maior dano contínuo e em área [/p][/font_size]")
	dialog_output.append("[font_size=30] Agora, manda bala!! [/font_size]")
	dialog_output.append("[font_size=30] Após destruir os inimigos,[p] avance na plataforma á direita [/p] [/font_size]")
	dialog_output.append("[color=gray](Pressione o botão abaixo para fechar o tutorial)[/color]")
	speech_tutorial.bbcode_text = dialog_output[currentIndex]
	
func showCurrentSpeech():
	speech_tutorial.bbcode_text = dialog_output[currentIndex]
	
func nextSpeech():
	currentIndex += 1
	if currentIndex < dialog_output.size():
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
