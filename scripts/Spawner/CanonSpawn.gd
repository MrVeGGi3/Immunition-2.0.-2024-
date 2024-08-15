extends Node3D


@export var minimum_distance = 15
#Projéteis

@onready var player = get_tree().get_first_node_in_group("player")
@onready var marker_3d = $Marker3D
@onready var projectile = preload("res://scenes/Characters/BoatLevel/CanonProjectile.tscn")
@onready var shoot_time = $ShootTime
@onready var canon_shoot = $CanonShoot


var can_shoot = true
var y_axis = 0.0
var x_axis = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var player_position = player.global_transform.origin
	var actual_position = marker_3d.global_transform.origin
	var distance_to_player = actual_position.distance_to(player_position)
	#print("Estou a %d metros de distância do player, falta %d metros para atirar:" % [distance_to_player, distance_to_player - minimum_distance])
	if can_shoot and  distance_to_player <= minimum_distance:
		canon_shoot.play()
		SpawnProjectile(actual_position, player_position)
	if !player:
		return
	
		


func SpawnProjectile(initial_position, final_position):
	var new_projectile = projectile.instantiate()
	get_parent().add_child(new_projectile)
	new_projectile.global_transform.origin = marker_3d.global_transform.origin
	if new_projectile.is_inside_tree():
		new_projectile.LaunchProjectile(initial_position, final_position, 45)
		shoot_time.start()
		can_shoot = false
	else:
		print("projétil não lançado adequadamente")
	

func _on_shoot_time_timeout():
	can_shoot = true
