extends RigidBody3D

@onready var timer_destruction: Timer = $TimerDestruction
@onready var ss_explosion = preload("res://scenes/effect/SSMissileExplosion.tscn")
@onready var ss_rb: RigidBody3D = $"."
@onready var missile_sound: AudioStreamPlayer3D = $MissileSound
@onready var area_3d: Area3D = $Area3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer_destruction.start()
	missile_sound.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _instantiate_explosion():
	var instance = ss_explosion.instantiate()
	get_parent().add_child(instance)
	if instance.is_inside_tree():
		instance.global_transform.origin = global_transform.origin
	
func _on_timer_destruction_timeout() -> void:
	_instantiate_explosion()
	queue_free()


func _on_body_entered(body : Node3D) -> void:
	print("Bazooka: Estou colidindo com o Chão")
	_instantiate_explosion()
	queue_free()


func _on_characterbody3d_entered(body: CharacterBody3D) -> void:
	if !body.is_in_group("player"):
		print("Bazooka: Estou colidindo com algum inimigo")
		_instantiate_explosion()
		queue_free()


func _on_area_3d_body_entered(body: Node3D) -> void:
	print("Bazooka: Estou colidindo com o Chão")
	_instantiate_explosion()
	queue_free()


func _on_characterbody_entered(body: Node3D) -> void:
	if !body.is_in_group("player"):
		print("Bazooka: Estou colidindo com algum inimigo")
		_instantiate_explosion()
		queue_free()
