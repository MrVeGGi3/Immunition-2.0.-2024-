extends Control

var loading_screen = "res://scenes/HUD/loading.tscn"
var menu_scene = "res://scenes/HUD/menu.tscn"
var logos
var current_logo = 0
var time_elapsed = 0
var logo_display_time = 3  

func _ready():
   
	logos = [$TextureRect1, $TextureRect2]

	for i in range(logos.size()):
		if i != current_logo:
			logos[i].hide()

func _process(_delta):
	time_elapsed += _delta

	if time_elapsed >= logo_display_time:
		time_elapsed = 0
		logos[current_logo].hide()

		if current_logo < logos.size() - 1:
			current_logo += 1
			logos[current_logo].show()
		else:
			get_tree().change_scene_to_file(loading_screen)

	if Input.is_action_just_pressed("start"):
		get_tree().change_scene_to_file(loading_screen)
