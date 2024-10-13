extends Node

@export_category("Propriedades")
@export var is_destroyed = false
@export var life : int = 30
var is_attacked = false


@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D #Substituir pelo AnimatedSprite3D depois
@onready var area_3d: Area3D = $Area3D
@onready var collision_time: Timer = $CollisionTime

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var bodies = area_3d.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemy") and !is_attacked and !is_destroyed:
			body.attack_pipe(self)
			is_attacked = true
			collision_time.start()
	
	
	
func damage(dmg):
	life -= dmg
	print("A vida total do Cano é", life)
	if life <= 0:
		is_destroyed = true
		mesh_instance_3d.visible = false
		#Colocar Animação de Destruído


func _on_collision_time_timeout() -> void:
	is_attacked = false


		
