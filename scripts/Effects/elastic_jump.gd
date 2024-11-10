extends Node3D

@onready var area_3d: Area3D = $MeshInstance3D/Area3D
@onready var elastic_jump_sound: AudioStreamPlayer3D = $MeshInstance3D/ElasticJumpSound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: CharacterBody3D) -> void:
	if body.is_in_group("player"):
		elastic_jump_sound.play()
		body._elastic_jump()
