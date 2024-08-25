extends Control

#Botões
@onready var b_front_walk: Button = $"Andar para Frente/B - Andar para Frente"
@onready var b_back_walk: Button = $"Andar para Trás/B - Andar para Trás"
@onready var b_right_walk: Button = $"Andar para Direita/B - Andar para Direita"
@onready var b_left_walk: Button = $"Andar para Esquerda/B - Andar para Esquerda"
@onready var b_jump: Button = $"Pular/B - Pular"
@onready var b_shoot: Button = $"Atirar/B - Atirar"
@onready var b_roda_arma: Button = $"RodaArma/B - RodaArma"
@onready var b_sistema_memoria: Button = $"SistemaMemoria/B - SistemaMemória"
@onready var b_selação_arma_1: Button = $"Seleção Arma 1/B - Seleção de Arma 1"
@onready var b_seleção_arma_2: Button = $"Seleção Arma 2/B - Seleção de Arma 2"
@onready var b_seleçãoo_arma_3: Button = $"Seleção Arma 3/B - Seleção de Arma 3"
@onready var b_memória_cima: Button = $"Seleção Memória Cima/B - Seleção de Memória Cima"
@onready var b_memória_baixo: Button = $"Seleção Memória Baixo/B - Seleção de Memória Baixo"
@onready var b_run: Button = $"Run/B - Run"


#Textos
@onready var t_front_walk: Label = $"Andar para Frente/T - Andar para Frente"
@onready var t_back_walk: Label = $"Andar para Trás/T - Andar para Trás"
@onready var t_right_walk: Label = $"Andar para Direita/T - Andar para Direita"
@onready var t_left_walk: Label = $"Andar para Esquerda/T - Andar para Esquerda"
@onready var t_jump: Label = $"Pular/T - Pular"
@onready var t_shoot: Label = $"Atirar/T - Atirar"
@onready var t_roda_arma: Label = $"RodaArma/T - Roda de Arma"
@onready var t_sistema_memoria: Label = $"SistemaMemoria/T - Sistema de Memória"
@onready var t_seleção_arma_1: Label = $"Seleção Arma 1/T - Seleção de Arma 1"
@onready var t_seleção_arma_2: Label = $"Seleção Arma 2/T - Seleção de Arma 2"
@onready var t_seleção_arma_3: Label = $"Seleção Arma 3/T - Seleção de Arma 3"
@onready var t_memoria_cima: Label = $"Seleção Memória Cima/T -MemóriaCima"
@onready var t_memoria_baixo: Label = $"Seleção Memória Baixo/T -MemóriaBaixo"
@onready var t_run: Label = $"Run/T - Run"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	b_front_walk.text = get_key_name_from_action("move_forwards")
	b_back_walk.text = get_key_name_from_action("move_backwards")
	b_right_walk.text = get_key_name_from_action("move_right")
	
func get_key_name_from_action(action_name : String):
	if InputMap.has_action(action_name):
		var events = InputMap.get_actions()
		for event in events:
			if event == action_name:
				var inputs =  InputMap.action_get_events(action_name)
				for input in inputs:
					pass
			
