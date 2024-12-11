extends Node3D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var phase_finished = $PhaseFinished
@onready var next_phase = $PhaseFinished/Panel/NextPhase
@onready var victory_song = $VictorySong
@onready var tutorial_bgm = $TutorialBGM
@onready var area_3d = $"Plataforma de Tutorial/MeshInstance3D40/Area3D"
@onready var pause_menu = $Player/PlayerHUD/pause_menu
@onready var minimap: Control = $Minimap

#Tutorial
@onready var tutorial_walking: Control = $Tutorial/TutorialWalking/TutorialWalkingBar
@onready var tutorial_walking_bar_2: Control = $Tutorial/TutorialWalking/TutorialWalkingBar2
@onready var tutorial_switch_weapons: Control = $Tutorial/TutorialSwitchWeapons/TutorialSwitchWeaponsBar
@onready var tutorial_jump_run: Control = $Tutorial/TutorialJumpRun/TutorialJumpRunBar
@onready var tutorial_memory: Control = $Tutorial/TutorialMemory/TutorialMemoryBar
@onready var tutorial_finish_level: Control = $Tutorial/TutorialFinishLevel/TutorialFinishLevelBar

#Inimigos Vermelhos á serem derrotados na primeira parte
@onready var enemy: CharacterBody3D = $Enemies/EnemiesGroupRed/Enemy
@onready var enemy_2: CharacterBody3D = $Enemies/EnemiesGroupRed/Enemy2
@onready var enemy_3: CharacterBody3D = $Enemies/EnemiesGroupRed/Enemy3
@onready var enemy_4: CharacterBody3D = $Enemies/EnemiesGroupRed/Enemy4

#Areas3D
@onready var area_3d_1: Area3D = $NextTutorialPlatforms/Areas3D/Area3D1
@onready var area_3d_2: Area3D = $NextTutorialPlatforms/Areas3D/Area3D2
@onready var area_3d_3: Area3D = $NextTutorialPlatforms/Areas3D/Area3D3
@onready var area_3d_4: Area3D = $NextTutorialPlatforms/Areas3D/Area3D4


#Inimigos à serem derrotados na última parte

const LEVEL_1 = "res://scenes/Levels/level_1.tscn"
var enemies_destroyed = false

#Plataformas
@onready var platform_1: Node3D = $NextTutorialPlatforms/Platform1
@onready var platform_2: Node3D = $NextTutorialPlatforms/Platform2
@onready var platform_3: Node3D = $NextTutorialPlatforms/Platform3
@onready var platform_4: Node3D = $NextTutorialPlatforms/Platform4

# Called when the node enters the scene tree for the first time.
func _ready():
	tutorial_bgm.play()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	player.disable_UI()
	next_phase.visible = false
	get_tree().paused = true
	tutorial_walking.visible = true
	tutorial_walking_bar_2.visible = false


func _process(_delta):
	if !tutorial_bgm.playing and !player.dead:
		tutorial_bgm.play()
	var bodies = area_3d.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"):
			end_phase()
	if player.dead:
		tutorial_bgm.stop()
	if tutorial_walking.visible and !pause_menu.visible:
		get_tree().paused = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if enemy.dead and enemy_2.dead and enemy_3.dead and enemy_4.dead:
		enemies_destroyed = true

func end_phase():
	tutorial_bgm.stop()
	victory_song.play()
	minimap.hide()
	next_phase.visible = true
	phase_finished.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	player.disable_UI()
	


func _on_next_phase_pressed():
	get_tree().change_scene_to_file(LEVEL_1)

func _pause_for_tutorial():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	player.disable_UI()
	get_tree().paused = true



func _on_area_3d_body_entered(body: CharacterBody3D) -> void:
	if body.is_in_group("player") and tutorial_walking.get_moved_variable():
		platform_1.queue_free()
		area_3d_1.queue_free()
		_pause_for_tutorial()
		tutorial_switch_weapons.visible = true
		


func _on_area_3d_2_body_entered(body: CharacterBody3D) -> void:
	if body.is_in_group("player") and enemies_destroyed:
		platform_2.queue_free()
		area_3d_2.queue_free()
		_pause_for_tutorial()
		tutorial_jump_run.visible = true
		


func _on_area_3d_3_body_entered(body: CharacterBody3D) -> void:
	if body.is_in_group("player"):
		platform_3.queue_free()
		area_3d_3.queue_free()
		_pause_for_tutorial()
		tutorial_memory.visible = true


func _on_area_3d_4_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		platform_4.queue_free()
		area_3d_4.queue_free()
		_pause_for_tutorial()
		tutorial_finish_level.visible = true
