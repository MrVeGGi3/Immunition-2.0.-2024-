extends CharacterBody3D

@export_category("Atributos")
@export var speed = 5
@export var life = 10
@export_category("Controle de Distância")
@export var distance_to_shoot = Vector3(5,5,5).normalized()
@export var keep_distance = Vector3()
@onready var CONTROL_BULLET_EMISSION = Global.CONTROL_BULLET_EMISSION
#Variável de comparação
var nearest_cell = null
#Variável de Controle
var is_moving = true
var is_shooting = false
var shoot_by_player = false
#Instâncias
var projectile = preload("res://scenes/effect/influenza_projectile.tscn")
#Referência de Localização
@onready var marker_3d = $Marker3D
#Timers
@onready var blink_cooldown = $BlinkCooldown
@onready var go_to_object = $GoToObject
@onready var shoot_time = $ShootTime
@onready var nav = $NavigationAgent3D
#Soms
@onready var influenza_projectile_sound = $InfluenzaProjectileSound
@onready var influenza_death = $InfluenzaDeath
#Corpo
@onready var influenza_animation = $InfluenzaAnimation
@onready var player = get_tree().get_first_node_in_group("player")

# Called when the node enters the scene tree for the first time.
func _ready():
	var pos_x = randf_range(0,4)
	var pos_y = randf_range(2,4)
	var pos_z = randf_range(0,4)
	keep_distance = Vector3(pos_x, pos_y, pos_z)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var player_position = player.marker_3d.global_transform.origin + keep_distance
	var current_position = global_transform.origin
	var next_location = nav.get_next_path_position()
	var new_velocity = (next_location - current_position).normalized() * speed
	velocity = velocity.move_toward(new_velocity, .25)
	move_and_slide()
		
	if !is_shooting:
		shoot_player()
	if is_moving:
		var cells = get_tree().get_nodes_in_group("cell")
		nearest_cell = null
		var shortest_distance = INF
		
		# Encontre a célula mais próxima
		for c in cells:
			var cell_distance = (c.global_transform.origin - current_position).length()
			if cell_distance < shortest_distance:
				shortest_distance = cell_distance
				nearest_cell = c

		if nearest_cell:
			var nearest_cell_position = nearest_cell.global_transform.origin
			nav.target_position = nearest_cell_position
		else:
			nav.target_position = player_position
				
		
		if current_position.distance_to(player_position) <= shortest_distance and !is_shooting:
				nav.target_position = player_position
				
		if shoot_by_player:
			nav.target_position = player_position
			
		
		
func _on_go_to_object_timeout():
	is_moving = true

func shoot_player():
	var new_projectile = projectile.instantiate()
	get_parent().add_child(new_projectile)
	new_projectile.global_transform.origin = marker_3d.global_transform.origin
	if new_projectile.is_inside_tree():
		influenza_projectile_sound.play()
		is_shooting = true
		shoot_time.start()
	else:
		print("projétil não lançado adequadamente")
	

func _on_shoot_time_timeout():
	is_shooting = false
	
func hit_by_lf(damage, speed_down):
	damage_effect()
	life -= damage
	speed -= speed_down
	shoot_by_player = true
	if life <= 0:
		kill()

func hit_by_mf(damage):
	damage_effect()
	life -= damage
	shoot_by_player = true
	if life <= 0:
		kill()
	
func hit_by_nf(damage):
	damage_effect()
	life -= damage * CONTROL_BULLET_EMISSION
	shoot_by_player = true
	if life <= 0:
		kill()

func kill():
	influenza_death.play()
	Global.influenza_destroyed += 1
	print("Eu destruí:", Global.influenza_destroyed)
	queue_free()

func damage_effect():
	influenza_animation.modulate = Color.RED
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(influenza_animation,"modulate", Color.WHITE, 0.3)

func phase_timeout():
	queue_free()
