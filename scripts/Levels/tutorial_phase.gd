extends Node3D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var phase_finished = $PhaseFinished
@onready var next_phase = $PhaseFinished/Panel/NextPhase
@onready var pathogen_tutorial = $PathogenTutorial
@onready var area_3d = $DevTorus/Area3D
@onready var victory_song = $VictorySong
@onready var tutorial_bgm = $TutorialBGM

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
			player.disable_UI()
			get_tree().paused = true
			phase_finished.visible = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	



	

func end_phase():
	tutorial_bgm.stop()
	victory_song.play()
	next_phase.visible = true
	phase_finished.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	player.disableUI()
	


func _on_next_phase_pressed():
	get_tree().change_scene_to_file(LEVEL_1)



