extends Node3D
@onready var moving_walls = get_tree().get_nodes_in_group("m_walls")
@onready var player = get_tree().get_first_node_in_group("player")
@onready var phase_ended: Control = $PhaseEnded
@onready var victory_song: AudioStreamPlayer = $VictorySong
@onready var retro_coin: AudioStreamPlayer = $RetroCoin
@onready var level_2bgm: AudioStreamPlayer = $Level2BGM

var message = "Muros reconstruídos com sucesso!"
var criteria1 = ""
var criteria2 = ""
var criteria3 = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	level_2bgm.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var m_wall_1 = moving_walls[0].get_wall_complete_status()
	var m_wall_2 = moving_walls[1].get_wall_complete_status()
	var m_wall_3 = moving_walls[2].get_wall_complete_status()
	var m_wall_4 = moving_walls[3].get_wall_complete_status()
	
	if m_wall_1 and m_wall_2 and  m_wall_3 and m_wall_4:
		level_2bgm.stop()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		player.disable_UI()
		victory_song.play()
		phase_ended.level_finished(2, message, criteria1, criteria2, criteria3)
		phase_ended.visible = true
		get_tree().paused = true
