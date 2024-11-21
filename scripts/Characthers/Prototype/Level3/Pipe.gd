extends Node3D

@export_category("Propriedades")
@export var max_life : int = 30
@export var is_destroyed = false
@export var life : int 
@export var is_attacked = false
@export var is_being_attacked = false

@onready var animated_sprite_3d: AnimatedSprite3D = $AnimatedSprite3D
@onready var area_3d: Area3D = $Area3D
@onready var collision_time: Timer = $CollisionTime

# Called when the node enters the scene tree for the first time.
func _ready():
	life = max_life


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var bodies = area_3d.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemy") and !is_attacked and !is_destroyed:
			is_being_attacked = true
			body.attack_pipe(self)
			is_attacked = true
			collision_time.start()
		else:
			is_being_attacked = false
	
	
	
func damage(dmg):
	life -= dmg
	print("A vida total do Cano é", life)
	if life <= 0:
		is_destroyed = true
		animated_sprite_3d.visible = false
		#Colocar Animação de Destruído


func _on_collision_time_timeout() -> void:
	is_attacked = false

func get_pipe_life():
	return life

func get_destroyed():
	return is_destroyed

func get_attacked():
	return is_being_attacked

		
