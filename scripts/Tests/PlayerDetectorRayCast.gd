extends CharacterBody3D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var RC: RayCast3D = $RayCast3D
var speed : float = 5.0
var is_walking : bool = false

@onready var NA: NavigationAgent3D = $NavigationAgent3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var player_position = player.marker_3d.global_transform.origin
	var current_position = global_transform.origin
	look_at(player_position)

	if RC.is_colliding():
		var collider = RC.get_collider()
		if collider == player:
			NA.target_position = player_position
			print("Estou indo atrás do Player")
	
	var next_position = NA.get_next_path_position()
	var new_velocity = (next_position - current_position).normalized()
	velocity = velocity.move_toward(new_velocity, .25 * speed)
	move_and_slide()
	
				
