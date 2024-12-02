extends Node3D

@onready var pipes = get_tree().get_nodes_in_group("pipe")
@onready var player = get_tree().get_first_node_in_group("player")
@onready var pipe_health_bar: Control = $PipeHealthBar
@onready var timer_counter: Control = $TimerCounter
@onready var phase_ended: Control = $PhaseEnded

@onready var victory_song: AudioStreamPlayer = $VictorySong

@onready var enemy_b_spawner: Node3D = $Spawners/EnemyBlueSpawner
@onready var enemy_r_spawner: Node3D = $Spawners/EnemyRedSpawner
@onready var enemy_g_spawner: Node3D = $Spawners/EnemyGreenSpawner

@onready var enemy_b2_spawner: Node3D = $Spawners/EnemyBlueSpawner2
@onready var enemy_r2_spawner: Node3D = $Spawners/EnemyRedSpawner2
@onready var enemy_g2_spawner:  Node3D = $Spawners/EnemyGreenSpawner2

@onready var enemy_b3_spawner: Node3D = $Spawners/EnemyBlueSpawner3
@onready var enemy_r3_spawner: Node3D = $Spawners/EnemyRedSpawner3
@onready var enemy_g3_spawner: Node3D = $Spawners/EnemyGreenSpawner3

@onready var pipe_done_sound: AudioStreamPlayer = $PipeDoneSound
@onready var level_3bgm: AudioStreamPlayer = $Level3BGM




var index = 0
var enemies
var message = "Vias respiratórias restauradas com sucesso! Obrigado por Jogar!"
var criteria1 = "Aprenda"
var criteria2 = "Preserve"
var criteria3 = "Proteja"

var can_spawn = true
var enemy_red
var enemy_blue
var enemy_green
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	level_3bgm.play()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	for i in range(1, pipes.size()):
		pipes[i].visible = false
	pipe_disable_visiblity()
	phase_ended.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	enemy_red = get_tree().get_nodes_in_group("red")
	enemy_blue = get_tree().get_nodes_in_group("blue")
	enemy_green = get_tree().get_nodes_in_group("green")

	if pipes[index].get_actioned() and index < 3 and can_spawn:
		pipe_enable_visiblity()
		if index == 0:
			enemy_b_spawner.start_timer()
			enemy_r_spawner.start_timer()
			enemy_g_spawner.start_timer()
			can_spawn = false
			
		if index == 1:
			enemy_b2_spawner.start_timer()
			enemy_r2_spawner.start_timer()
			enemy_g2_spawner.start_timer()
			can_spawn = false
		if index == 2:
			enemy_b3_spawner.start_timer()
			enemy_r3_spawner.start_timer()
			enemy_g3_spawner.start_timer()
			can_spawn = false
			
	if pipes[2].get_restored():
		level_3bgm.stop()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		player.disable_UI()
		victory_song.play()
		phase_ended.level_finished(3, message, criteria1, criteria2, criteria3)
		phase_ended.visible = true
		phase_ended._hide_button()
		get_tree().paused = true
		

func _on_count_timeout() -> void:
	pipe_disable_visiblity()
	pipes[index].time_end()
	destroy_all_enemies()
	pipe_done_sound.play()
	if index < 2:
		index += 1
	enemy_b_spawner.stop_spawn()
	enemy_r_spawner.stop_spawn()
	enemy_g_spawner.stop_spawn()
	enemy_b2_spawner.stop_spawn()
	enemy_r2_spawner.stop_spawn()
	enemy_g2_spawner.stop_spawn()
	enemy_b3_spawner.stop_spawn()
	enemy_r3_spawner.stop_spawn()
	enemy_g3_spawner.stop_spawn()
	if index < 3:
		pipes[index].visible = true
	pipe_health_bar._next_index()
	can_spawn = true
	
	
func pipe_disable_visiblity():
	pipe_health_bar.visible = false
	timer_counter.visible = false
	
func pipe_enable_visiblity():
	pipe_health_bar.visible = true
	timer_counter.visible = true

func destroy_all_enemies():
	for enemy in enemy_red:
		enemy._time_ended()
	for enemy in enemy_blue:
		enemy._time_ended()
	for enemy in enemy_green:
		enemy._time_ended()
	
