extends Control
@onready var loading_animation = $AnimatedSprite2D

var menu_scene = "res://scenes/HUD/menu.tscn"


func _ready():
	loading_animation.play("animation")


func _on_animated_sprite_2d_animation_finished() -> void:
	get_tree().change_scene_to_file(menu_scene)
