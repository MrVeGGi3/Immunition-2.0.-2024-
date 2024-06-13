extends Node3D

@onready var player = get_tree().get_first_node_in_group("player")
#Plataforma do Extractor
@onready var area_platform = $ExtractorPlatform/AreaPlatform
@onready var press_f = $ExtractorPlatform/PressF
@onready var error_audio = $ExtractorPlatform/ErrorAudio
#Câmera e Animação
@onready var camera_movement = %CameraMovement
@onready var cutscene_camera = $CameraPosition/CutsceneCamera
@onready var player_camera = $Player/Camera3D

#Objetivos
@onready var extractos_collected = $ExtractosCollected
@onready var influenza_count = $InfluenzaCount
#Fim de Fase
@onready var next_phase_collision = $MapLevel1/DevTorus/NextPhaseCollision
@onready var phase_ended = $PhaseEnded


@onready var influenza = get_tree().get_nodes_in_group("influenza")
@onready var cells = get_tree().get_nodes_in_group("cell")
@onready var player_hud = $Player/PlayerHUD

@onready var cell_spawner_3d = $CellSpawner3d
@onready var influenza_spawner_3d = $InfluenzaSpawner3d

var is_influenza_captured = false
#Booleanas de Controle
var is_extractor_build = false
var is_entered_platform = false
# Called when the node enters the scene tree for the first time.
func _ready():
	press_f.visible = false
	influenza_count.visible = false
	for inf in influenza:
		inf.visible = false
	for cell in cells:
		cell.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var go_to_next_phase = Global.is_enemies_destroyed	
	if Global.influenza_destroyed >= 3 and !is_influenza_captured:
		execute_second_animation()
	
	if go_to_next_phase:
		var duddies = next_phase_collision.get_overlapping_bodies()
		for dude in duddies:
			if dude.is_in_group("player"):
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				player.disable_UI()
				phase_ended.visible = true
				get_tree().paused = true
		
	if is_entered_platform:
		if Input.is_action_just_pressed("Interact") and !is_extractor_build:
			extractos_collected.visible = false
			player.set_physics_process(false)
			is_extractor_build = true
			press_f.visible = false
			influenza_count.visible = true
			cutscene_cells()
			
		if Input.is_action_just_pressed("Interact") and is_extractor_build:
			error_audio.play()
			
func cutscene_cells():
	is_extractor_build = true
	player_hud.visible = false
	cutscene_camera.make_current()
	camera_movement.play("CameraFirstPoint")

func spawn_cells():
	cell_spawner_3d._on_timer_timeout()
	
func spawn_influenza():
	influenza_spawner_3d._on_timer_timeout()

func return_player_camera():
	player_hud.visible = true
	camera_movement.stop()
	player_camera.make_current()
	player.set_physics_process(true)
	
func _on_area_platform_body_entered(body):
	if body.is_in_group("player"):
		press_f.show()
		is_entered_platform = true
	else:
		return
		
		
func execute_second_animation():
	Global.is_enemies_destroyed = true
	player_hud.visible = false
	influenza_count.visible = false
	player.set_physics_process(false)
	cutscene_camera.make_current()
	camera_movement.play("CameraFinalPoint")
	is_influenza_captured = true
