class_name Cell
extends CharacterBody3D

@export_category("Move")
@export var speed = 2
@export var move_radius = 5  # Raio de movimento em torno do spawner
@export var distance_to_run = 8 
#Booleanas
var is_moving : bool = true
var is_catched_by_influenza : bool = false
var new_position : Vector3
@onready var movement_time = $MovementTime
@onready var area_3d = $Area3D
var escape_vector = Vector3(0,0,0)
var infected_cell = preload("res://scenes/testing/Infected_cells.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_moving:
		_set_new_position()
		if global_position.distance_to(new_position) <= 0.2 or global_position.distance_to(new_position) == 0.0:
			_set_new_position()
		var direction = (new_position - global_transform.origin).normalized()
		var movement = direction * speed * delta
		if global_transform.origin.distance_to(new_position) <= movement.length():
			global_transform.origin = new_position
			is_moving = false
			movement_time.start()
		else:
			global_transform.origin += movement
	
	
	var influenza = get_tree().get_nodes_in_group("influenza")
	for i in influenza:
		var influenza_distance = (i.global_transform.origin - global_transform.origin).normalized()
		if global_transform.origin.distance_to(i.global_transform.origin) <= distance_to_run and !is_catched_by_influenza:
			var direction_to_influenza = (global_transform.origin - i.global_transform.origin).normalized()
			escape_vector += direction_to_influenza
			escape_vector = escape_vector.normalized() * speed * delta
			global_transform.origin += escape_vector
		
	
	var bodies = area_3d.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("influenza"):
			_change_type()
			is_catched_by_influenza = true
			is_moving = false
			movement_time.stop()

func _set_new_position():
	var angle = randf_range(0, TAU)  
	var distance = randf_range(0, move_radius)
	var new_pos_x = cos(angle) * distance
	var new_pos_z = sin(angle) * distance
	new_position = global_transform.origin + Vector3(new_pos_x, 0, new_pos_z)


func _on_movement_time_timeout():
	is_moving = true

func _change_type():
	Global.contamined_cells += 1
	print("o número de células infectadas é: ", Global.contamined_cells)
	var new_infected_cell = infected_cell.instantiate()
	new_infected_cell.global_transform.origin = global_transform.origin
	get_parent().add_child(new_infected_cell)
	queue_free()
