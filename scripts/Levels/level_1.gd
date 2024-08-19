extends Node3D

@onready var player = get_tree().get_first_node_in_group("player")
#Plataforma do Extractor
@onready var area_platform = $ExtractorPlatform/AreaPlatform
@onready var error_audio = $ExtractorPlatform/ErrorAudio
@onready var press_f = $Player/PlayerHUD/PressInteraction

#Câmera e Animação
@onready var camera_movement = %CameraMovement
@onready var cutscene_camera = %CutsceneCamera
@onready var player_camera = $Player/Camera3D

#Objetivos
@onready var extractos_collected = $ExtractosCollected
#Fim de Fase
@onready var next_phase_collision = %NextPhaseCollision
@onready var phase_ended = $PhaseEnded


@onready var player_hud = $Player/PlayerHUD

@onready var cell_spawner_3d = $CellSpawner3d
@onready var influenza_spawner_3d = $InfluenzaSpawner3d
@onready var level_1bgm = $Level1BGM
@onready var victory_song = $VictorySong
@onready var timer_counter = $TimerCounter
@onready var count = $TimerCounter/Control2/Count

@export_category("Critérios")
@onready var message = "Com as proteínas extraídas da fibra muscular, o sistema imune tem mais força para derrotar a infecção da Influenza!"
@onready var criteria1 = "Células Vivas" 
@onready var criteria2 = "Patógenos Destruídos"
@onready var criteria3 = "Vida Restante"
#Booleanas de Controle
var is_extractor_build = false
var is_entered_platform = false
var go_to_next_phase = false
var start_enemies
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.cells_in_scene = 0.0
	Global.contamined_cells = 0.0
	Global.pathogen_killed = 0.0	
	timer_counter.hide()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	press_f.visible = false
	level_1bgm.play()
	start_enemies = get_tree().get_nodes_in_group("enemy").size()
	print("O número de inimigos iniciais é:", start_enemies)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !level_1bgm.playing and !player.dead:
		level_1bgm.play()
	
	if go_to_next_phase:
		var duddies = next_phase_collision.get_overlapping_bodies()
		for dude in duddies:
			if dude.is_in_group("player"):
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				player.disable_UI()
				level_1bgm.stop()
				victory_song.play()
				phase_ended.count_score_lvl_1(Global.contamined_cells, Global.cells_in_scene, Global.pathogen_killed, start_enemies, player.vida, player.vida_maxima)
				print("O número de células contaminadas:", Global.contamined_cells)
				print("O número de células no total:", Global.cells_in_scene)
				print("O númerod de Inimigos derrotados:", Global.pathogen_killed)
				print("O número de Inimigos na Fase:", start_enemies)
				print("Vida atual do Player:", player.vida)
				print("A vida máxima do Player:", player.vida_maxima)
				phase_ended.level_finished(1, message, criteria1, criteria2, criteria3)
				phase_ended.visible = true
				get_tree().paused = true
		
	if is_entered_platform:
		if Input.is_action_just_pressed("Interact") and !is_extractor_build:
			extractos_collected.visible = false
			player.set_physics_process(false)
			is_extractor_build = true
			press_f.hide()
			cutscene_cells()
			
		if Input.is_action_just_pressed("Interact") and is_extractor_build:
			error_audio.play()
		
	if player.dead:
		level_1bgm.stop()
	
		
func cutscene_cells():
	is_extractor_build = true
	player.disable_UI()
	cutscene_camera.make_current()
	camera_movement.play("CameraFirstPoint")

func spawn_cells():
	cell_spawner_3d._on_timer_timeout()
	
func spawn_influenza():
	influenza_spawner_3d.can_create_influ = true
	influenza_spawner_3d._on_timer_timeout()
	
func return_player_camera():
	player.restore_UI()
	camera_movement.stop()
	player_camera.make_current()
	player.set_physics_process(true)
	
func _on_area_platform_body_entered(body):
	if body.is_in_group("player") and !is_extractor_build:
		is_entered_platform = true
		press_f.show()
	else:
		return
		
		
func execute_second_animation():
	print("Essa função está sendo executada:Animação")
	go_to_next_phase = true
	player.disable_UI()
	camera_movement.play("CameraFinalPoint")
	

func start_timer():
	timer_counter.show()
	count.start()


func _on_count_timeout():
	timer_counter.hide()
	influenza_spawner_3d.can_create_influ = false
	player.set_physics_process(false)
	execute_second_animation()

func destroy_enemies_in_level():
	var influenza = get_tree().get_nodes_in_group("influenza")
	var inf_cell = get_tree().get_nodes_in_group("infected_cell")
	for i in influenza:
		i.phase_timeout()
	for j in inf_cell:
		j.phase_timeout()
	
