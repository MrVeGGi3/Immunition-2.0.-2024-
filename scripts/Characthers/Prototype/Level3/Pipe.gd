extends Node3D

@export_category("Propriedades")
@export var max_life : int = 30
@export var is_destroyed = false
@export var life : int 
@export var is_attacked = false
@export var is_being_attacked = false
@export var restored = false
@export var actioned = false
@export var can_activate = false

@onready var counter = get_tree().get_first_node_in_group("counter")
@onready var animated_sprite_3d: AnimatedSprite3D = $AnimatedSprite3D
@onready var area_3d: Area3D = $Area3D
@onready var collision_time: Timer = $CollisionTime
@onready var player = get_tree().get_first_node_in_group("player")
# Called when the node enters the scene tree for the first time.
func _ready():
	life = max_life
	area_3d.collision_mask = 2 | 4
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var bodies = area_3d.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemy") and !is_attacked and !is_destroyed:
			is_being_attacked = true
			animated_sprite_3d.play("attacked")
			body.attack_pipe(self)
			is_attacked = true
			collision_time.start()
		else:
			is_being_attacked = false
			animated_sprite_3d.play("default")
	
	if can_activate and Input.is_action_just_pressed("Interact"):
			print("Cano Acionado para Manutenção!")
			counter._start_count()
			player.play_button_sound()
			actioned = true
			area_3d.collision_mask = 4
			can_activate = false
	
	
	
func damage(dmg):
	life -= dmg
	print("A vida total do Cano é", life)
	if life <= 0:
		is_destroyed = true
		animated_sprite_3d.play("broken")
		#Colocar Animação de Destruído


func _on_collision_time_timeout() -> void:
	is_attacked = false

func get_pipe_life():
	return life

func get_destroyed():
	return is_destroyed

func get_attacked():
	return is_being_attacked

func get_restored():
	return restored

func get_actioned():
	return actioned

func time_end():
	restored = true
	animated_sprite_3d.play("confirm")
		


func _on_area_3d_body_entered(body: CharacterBody3D) -> void:
	if body.is_in_group("player") and !can_activate and !actioned:
		body.can_interact()
		can_activate = true




func _on_area_3d_body_exited(body: CharacterBody3D) -> void:
	if body.is_in_group("player"):
		body.cant_interact()
		if !actioned:
			can_activate = false
