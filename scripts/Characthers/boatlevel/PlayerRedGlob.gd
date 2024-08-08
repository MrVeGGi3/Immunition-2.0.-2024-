extends CharacterBody3D
#Varáveis principais
@export var automatic_velocity = 5.0
@export var side_velocity = 2.0
@export var life = 10
#Booleanas de Controle
var is_shooting = false
var is_stopped = false
var can_collide = true

#Chamadas de Objetos
@onready var marker_3d = $Marker3D
@onready var shoot_timer = $ShootTimer
@onready var disable_enemy_collision = $DisableEnemyCollision

#Instância
var projectile = preload("res://scenes/Characters/BoatLevel/PlayerProjectile.tscn")
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#Sons
@onready var blaster_sound = $BlasterSound



	
func _physics_process(_delta):
	if life <= 0:
		death()
	var input_dir = Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards") #definir os movimentos de cada vetor 
	var direction = (transform.basis * Vector3(0, 0, input_dir.x)).normalized()
	
	if direction and !is_stopped:
		velocity.z = direction.z * side_velocity
		velocity.x = automatic_velocity
	elif direction and is_stopped:
		velocity.z = direction.z * side_velocity
	else:
		velocity.x = automatic_velocity
	if Input.is_action_just_pressed("jump") and !is_shooting:
		shoot_proj()
		
	move_and_slide()

func shoot_proj():
	var new_projectile = projectile.instantiate()
	get_parent().add_child(new_projectile)
	new_projectile.global_transform.origin = marker_3d.global_transform.origin
	if new_projectile.is_inside_tree():
		blaster_sound.play()
		is_shooting = true
		shoot_timer.start()
	else:
		print("projétil não lançado adequadamente")
	
func _on_shoot_timer_timeout():
	is_shooting = false

func damage(dmg):
	if can_collide:
		life -= dmg
		can_collide = false
		disable_enemy_collision.start()
		print("Player recebeude dano:", dmg)

func death():
	queue_free()

func _on_disable_enemy_collision_timeout():
	can_collide = true
