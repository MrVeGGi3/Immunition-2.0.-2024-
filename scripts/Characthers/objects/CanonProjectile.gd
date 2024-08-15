extends Node3D

@export var damage = 4
const gravity = 9.8
#Chamadas 
@onready var player = get_tree().get_first_node_in_group("player")
@onready var area_3d = $Area3D
@onready var canon_projectile = $"."
@onready var destruction_timer = $DestructionTimer

#Variáveis de Controle 
var is_launched = false
#Variáveis de Cálculo
var y_axis : float
var x_axis : float
var throwing_angle : float
var start_position :  Vector3
var throwing_direction : float
var n_direction : Vector3
var p_speed : float
var throw_angle_degrees : float
var time : float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if is_launched:
		y_axis = p_speed * sin(deg_to_rad(throwing_angle)) * time - 0.5 * gravity * pow(time, 2)
		if y_axis > 0.0:
			x_axis = p_speed * cos(deg_to_rad(throwing_angle)) * time
			global_transform.origin = start_position + n_direction * x_axis + Vector3(0, y_axis, 0)

			
func LaunchProjectile(initial_position : Vector3, final_position : Vector3, angle : float):
	var direction = initial_position.distance_to(final_position)
	p_speed = sqrt(gravity * direction / sin(2 * deg_to_rad(angle)))
	time = 0.0
	start_position = initial_position
	n_direction = (final_position - initial_position).normalized()
	throwing_angle = angle
	is_launched = true
	destruction_timer.start()
	
func _physics_process(delta):
	var bodies = area_3d.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"):
			print("Projétil: Causei %d de dano no player: %[damage]")
			player.damage(damage)
			queue_free()
		if body.is_in_group("blood"):
			queue_free()
		else:
			queue_free()


func _on_destruction_timer_timeout():
	queue_free()
