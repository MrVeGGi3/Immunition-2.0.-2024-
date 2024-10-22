extends CharacterBody3D

@export_category("Propriedades")
@export var SPEED = 5.0
@export var life : int = 30
@export var damage : int = 3
@export var poison_damage : int = 1

@onready var nav: NavigationAgent3D = $NavigationAgent3D
@onready var poison_emitter: Marker3D = $PoisonEmitter
@onready var poison_timer_emmiter: Timer = $PoisonTimerEmmiter
@onready var area_3d: Area3D = $Colliding/Area3D
@onready var poison_area_3d: Area3D = $PoisonArea3D

@onready var poison_sound: AudioStreamPlayer = $PoisonSound


var current_position
@export var can_throw = true


func _physics_process(delta: float) -> void:
	current_position = global_transform.origin
	var next_position = nav.get_next_path_position()
	var new_velocity = (next_position - current_position).normalized()
	velocity = velocity.move_toward(new_velocity, 0.1 * SPEED)
	move_and_slide()
	
	var bodies = area_3d.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"):
			poison_sound.play()
			body._damage(damage)
			print("Diarréia: Causei dano ao player")
	
	var boties = poison_area_3d.get_overlapping_bodies()
	for bot in boties:
		if bot.is_in_group("player"):
			bot._damage(poison_damage * delta)
			print("Veneno: Causei dano ao player")


	
	
