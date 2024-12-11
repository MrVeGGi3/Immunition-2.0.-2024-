extends Node3D
@onready var moving_walls = get_tree().get_nodes_in_group("m_walls")
@onready var player = get_tree().get_first_node_in_group("player")
@onready var phase_ended: Control = $PhaseEnded
@onready var victory_song: AudioStreamPlayer = $VictorySong
@onready var retro_coin: AudioStreamPlayer = $RetroCoin
@onready var level_2bgm: AudioStreamPlayer = $Level2BGM

var start_enemies
var seconds : float
var message = "Muros reconstruídos com sucesso!"
var criteria1 = "Tempo do Jogo"
var criteria2 = "Patógenos Destruídos"
var criteria3 = "Vida do Player"

@onready var wall_pieces_hud: Control = $WallPiecesHUD
@onready var wall_pieces_available: Label = $WallPiecesHUD/WallPiecesAvailable



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.wall_piece = 0
	start_enemies = get_tree().get_nodes_in_group("enemy").size()
	Global.pathogen_killed = 0 
	Global.score_index = 1
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	level_2bgm.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wall_pieces_available.text = str(Global.wall_piece)
	var m_wall_1 = moving_walls[0].get_wall_complete_status()
	var m_wall_2 = moving_walls[1].get_wall_complete_status()
	var m_wall_3 = moving_walls[2].get_wall_complete_status()
	var m_wall_4 = moving_walls[3].get_wall_complete_status()
	seconds += delta
	
	if player.dead:
		level_2bgm.stop()
			
	
	if m_wall_1 and m_wall_2 and  m_wall_3 and m_wall_4:
		level_2bgm.stop()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		wall_pieces_hud.visible = false
		player.disable_UI()
		victory_song.play()
		phase_ended.level_finished(2, message, criteria1, criteria2, criteria3)
		phase_ended.count_score_lvl_2(seconds, Global.pathogen_killed, player.vida, 240.00, start_enemies,player.vida_maxima)
		phase_ended.visible = true
		get_tree().paused = true
