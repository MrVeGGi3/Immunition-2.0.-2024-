extends Node3D


@onready var area_3d: Area3D = $Activator/Area/Area3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

#Variáveis
@export var pieces_to_open : int = 5
var can_change = false
@export var anim_1_done : bool = false
@export var anim_2_done : bool = false
@export var anim_3_done : bool = false
@export var anim_4_done : bool = false
@export var anim_5_done : bool = false
#Sons
@onready var error_audio: AudioStreamPlayer = $ErrorAudio

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var bodies = area_3d.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"):
			can_change = true
			body.can_interact()
		
	
	if can_change and Input.is_action_just_pressed("Interact"):
		error_audio.play()
		if Global.wall_piece <= pieces_to_open:
			var percentage = int(Global.wall_piece/pieces_to_open * 100)
			if percentage >= 20 and percentage < 40 and !anim_1_done:
				animation_player.play("20%")
			elif percentage >= 40 and percentage < 60 and !anim_2_done:
				animation_player.play("40%")
			elif percentage >= 60 and percentage < 80 and !anim_3_done:
				animation_player.play("60%")
			elif percentage >= 80 and percentage < 100 and !anim_4_done:
				animation_player.play("80%")
			elif percentage == 100:
				animation_player.play("100%")
		
