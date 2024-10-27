extends Node3D

@export_category("Propriedades")
@export var force_throw_x = 0.0
@export var force_throw_z = 20.0
@export var force_throw_y = 3.0

@onready var player = get_tree().get_first_node_in_group("player")
@onready var ss_missile = preload("res://scenes/effect/SalineSolutionMissile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.bazooka_ui.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("change_bazooka"):
		player._disconnect_animations()
	if Input.is_action_just_pressed("shoot") and player.can_shoot_bz:
		_instantiate_ss_missile()
		
	
func _instantiate_ss_missile():
	var instance = ss_missile.instantiate()
	get_parent().add_child(instance)
	if instance.is_inside_tree():
		instance.global_transform.origin = player.bazooka_position.global_transform.origin
		var impulse_direction = force_throw_z *  - player.bazooka_position.global_transform.basis.z.normalized()
		instance.apply_central_impulse(impulse_direction)
		instance.look_at(instance.global_transform.origin + impulse_direction)		
