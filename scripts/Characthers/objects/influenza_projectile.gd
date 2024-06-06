extends Node3D

@onready var player = get_tree().get_first_node_in_group("player")
@export_category("Variáveis")
@export var distance = 10
@export var speed = 4
@export var damage = 1

@onready var area_3d = $Area3D
@onready var is_shooting = true
@onready var damage_count = $DamageCount
var target_position = Vector3()
@onready var destruction_timer = $Destruction

# Called when the node enters the scene tree for the first time.
func _ready():
	if player:
		target_position = player.global_transform.origin
	destruction_timer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_shooting:
		var direction = (target_position - global_transform.origin).normalized()
		var movement = direction * speed * delta 
		global_transform.origin += movement
		var bodies = area_3d.get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("player") and is_shooting:
				player._damage(damage)
				queue_free()
				is_shooting = false
				damage_count.start()

func _on_damage_count_timeout():
	is_shooting = true


func _on_destruction_timeout():
	queue_free()
