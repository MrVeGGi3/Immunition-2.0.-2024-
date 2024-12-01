extends Node3D

@onready var area_3d: Area3D = $Area3D
@onready var coin_sound = get_tree().get_first_node_in_group("c_sound")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var bodies = area_3d.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"):
			destroy_and_add()
			
func destroy_and_add():
	coin_sound.play()
	Global.wall_piece += 1
	print("O número total de peças coletadas é:", Global.wall_piece)
	queue_free()
