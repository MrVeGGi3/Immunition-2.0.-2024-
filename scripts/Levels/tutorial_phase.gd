extends Node3D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var phase_finished = $PhaseFinished
@onready var next_phase = $PhaseFinished/Panel/NextPhase
@onready var pathogen_tutorial = $PathogenTutorial
@onready var victory_song = $VictorySong
@onready var tutorial_bgm = $TutorialBGM
@onready var area_3d = $"Plataforma de Tutorial/MeshInstance3D40/Area3D"
@onready var pause_menu = $Player/PlayerHUD/pause_menu

const LEVEL_1 = "res://scenes/Levels/level_1.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	tutorial_bgm.play()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	player.disable_UI()
	next_phase.visible = false
	get_tree().paused = true
	pathogen_tutorial.visible = true


func _process(delta):
	var bodies = area_3d.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"):
			end_phase()
	if player.dead:
		tutorial_bgm.stop()
	if pathogen_tutorial.visible and !pause_menu.visible:
		get_tree().paused = true
		

	

func end_phase():
	tutorial_bgm.stop()
	victory_song.play()
	next_phase.visible = true
	phase_finished.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	player.disable_UI()
	


func _on_next_phase_pressed():
	get_tree().change_scene_to_file(LEVEL_1)



