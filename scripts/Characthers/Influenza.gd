extends CharacterBody3D

@export var speed = 15
var nearest_cell = null
var is_moving = true
@onready var go_to_object = $GoToObject

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_moving:
		var cells = get_tree().get_nodes_in_group("cell")
		nearest_cell = null
		var shortest_distance = INF
		var current_position = global_transform.origin

		# Encontre a célula mais próxima
		for c in cells:
			var cell_distance = (c.global_transform.origin - current_position).length()
			if cell_distance < shortest_distance:
				shortest_distance = cell_distance
				nearest_cell = c

		if nearest_cell:
			var nearest_cell_position = nearest_cell.global_transform.origin
			var direction = (nearest_cell_position - current_position).normalized()
			var movement = direction * speed * delta
			
			# Verifique se está perto o suficiente para chegar na célula
			if current_position.distance_to(nearest_cell_position) <= movement.length():
				global_transform.origin = nearest_cell_position
				is_moving = false  
				go_to_object.start()
			else:
				global_transform.origin += movement
				
				
	#var player = get_tree().get_first_node_in_group("player")
	#var player_position = player.global_transform.origin
	#var player_distance = (player_position - global_transform.origin).normalized()

	#if player_distance < shortest_distance:
		#move_to_object(player_position)
	#else:
		#move_to_object(nearest_cell_position) 
			
#func move_to_object(object : Vector3):
	#var direction = (object - global_transform.origin).normalized()
	#var movement = direction * speed * get_process_delta_time()
	#if global_transform.origin.distance_to(object) <= movement.lenght():
		#global_transform.origin = object
	#else:
		#global_transform.origin += movement
		
func _on_go_to_object_timeout():
	is_moving = true
