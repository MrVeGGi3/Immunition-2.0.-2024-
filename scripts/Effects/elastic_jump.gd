extends Node3D

@onready var area_3d: Area3D = $MeshInstance3D/Area3D
@onready var elastic_jump_sound: AudioStreamPlayer3D = $MeshInstance3D/ElasticJumpSound


func _on_area_3d_body_entered(body: CharacterBody3D) -> void:
	if body.is_in_group("player"):
		elastic_jump_sound.play()
		body._elastic_jump()
