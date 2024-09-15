extends Node3D


@export var speed = 5
@onready var area_3d = $Area3D
@onready var auto_destruction_timer = $AutoDestructionTimer
@onready var player = get_tree.get_first_node_in_group("player")
@onready var enemy_position = global_transform.origin
var player_position
func _ready():
	player_position = player.global_transform.origin
	auto_destruction_timer.start()
	
func _process(delta):
	var direction = (enemy_position - player_position).normalized()
	var movement = direction * speed * delta
	global_transform.origin += movement
	var bodies = area_3d.get_overlapping_bodies()
	
	for body in bodies:
		if body.is_in_group("player"):
			body.damage(3)
			queue_free()

func _on_timer_timeout():
	queue_free()
