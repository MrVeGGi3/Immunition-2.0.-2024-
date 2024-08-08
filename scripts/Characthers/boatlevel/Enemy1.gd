extends Node3D

@export var life = 6
@export var player_damage = 2
@export var rec_damage = 3
@export var collision_distance = 2.0
@onready var area_3d = $Area3D
@onready var player = get_tree().get_first_node_in_group("player")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if life <= 0:
		queue_free()
	var bodies = area_3d.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"):
			print("Enemy1: Estou colidindo com o Player")
			body.damage(player_damage)
		if body.is_in_group("PlayerProj"):
			damage(rec_damage)
			body.queue_free()


func damage(dmg):
	life -= dmg
	print("Enemy1 recebeu dano de:", dmg)






