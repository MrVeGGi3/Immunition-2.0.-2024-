extends MeshInstance3D

@onready var opening_door = $OpeningDoor
@onready var animation_player = $AnimationPlayer


var is_played = false


func _process(_delta):
	if Global.extractors_collected == 3 and !is_played:
		animation_player.play("Aberto")
		is_played = true
		



	
