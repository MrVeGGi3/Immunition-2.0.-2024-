extends CharacterBody3D

@export var speed = 10
@export var damage = 3
@onready var proj_auto_destruction = $ProjAutoDestruction



# Called when the node enters the scene tree for the first time.
func _ready():
	proj_auto_destruction.start()

# Called every frame. 'delta' is the elapsed time since the previous frame
func _physics_process(delta):
	var movement = speed * delta
	global_transform.origin.x += movement

			
func _on_proj_auto_destruction_timeout():
	queue_free()
