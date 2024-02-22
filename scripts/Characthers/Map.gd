extends Control

@onready var player = $"../Player"
var mapa_3d
@onready var textura_mapa = $TextureRect

func _ready():
	# Carrega a cena do mapa 3D
	mapa_3d = preload("res://scenes/Levels/world.tscn").instance()
	add_child(mapa_3d)

	# Conecta ao sinal de processamento para atualizar o HUD
	set_process(true)

func _process(delta):
	# Atualiza a posição do jogador no HUD
	if player:
		# Projeta a posição 3D do jogador para 2D na tela
		var posicao_proj = mapa_3d.world_to_screen(player.global_transform.origin)
		textura_mapa.rect_position = posicao_proj - textura_mapa.rect_size / 2

func set_jogador(player_ref):
	player = player_ref
