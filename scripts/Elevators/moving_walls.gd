extends Node3D


@onready var area_3d: Area3D = $Activator/Area/Area3D
@onready var player = get_tree().get_first_node_in_group("player")
#Variáveis
@export var pieces_to_open : int = 5
var initial_pieces_open
var can_change = false
var percentage 
@export var anim_1_done : bool = false
@export var anim_2_done : bool = false
@export var anim_3_done : bool = false
@export var anim_4_done : bool = false
@export var anim_5_done : bool = false
@export var wall_complete : bool = false
#Sons
@onready var error_audio: AudioStreamPlayer = $ErrorAudio
#HUD
@onready var pieces_wall_hud: Control = $PiecesWallHUD
@onready var need_pieces_hud: Control = $NeedPiecesHUD

#Labels
@onready var quantity_pieces: Label = $NeedPiecesHUD/QuantityPieces

#Animation
@onready var wall_animation: AnimationPlayer = $WallAnimation
@onready var pieces_hud_animation: AnimationPlayer = $PiecesWallHUD/PiecesHUDAnimation


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pieces_wall_hud.visible = false
	need_pieces_hud.visible = false
	quantity_pieces.text = str(pieces_to_open)
	initial_pieces_open = pieces_to_open


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:	
	quantity_pieces.text = str(pieces_to_open)	
		
	if can_change and Input.is_action_just_pressed("Interact"):
		error_audio.play()
		need_pieces_hud.visible = false
		if Global.wall_piece > 0:
			
			subtraction_pieces(Global.wall_piece, pieces_to_open)
			percentage = (pieces_to_open  * 100.00 / initial_pieces_open) 
			print(percentage)
			if percentage >= 80.0 and percentage < 100.0 and !anim_1_done:
				subtraction_pieces(Global.wall_piece, pieces_to_open)
				wall_animation.play("20%")
			elif percentage >= 60.0 and percentage < 80.0 and !anim_2_done:
				subtraction_pieces(Global.wall_piece, pieces_to_open)
				wall_animation.play("40%")
			elif percentage >= 40.0 and percentage < 60.0 and !anim_3_done:
				subtraction_pieces(Global.wall_piece, pieces_to_open)
				wall_animation.play("60%")
			elif percentage >= 20.0 and percentage < 40.0 and !anim_4_done:
				subtraction_pieces(Global.wall_piece, pieces_to_open)
				wall_animation.play("80%")
			elif percentage == 0.0:
				subtraction_pieces(Global.wall_piece, pieces_to_open)
				wall_animation.play("100%")
				area_3d.monitoring = false
				wall_complete = true
		else:
			pieces_wall_hud.visible = true
			pieces_hud_animation.play("cant_construct")
	
		
func subtraction_pieces(pieces, pc):
	var last_pices = pieces
	var last_pieces_to_open = pc
	if pieces <= pieces_to_open:
		pieces -= last_pices
		pc -= last_pices
	elif pieces > pieces_to_open:
		pieces -= last_pieces_to_open
		pc -= last_pieces_to_open
		
	Global.wall_piece = pieces
	pieces_to_open = pc
	
	print("A quantidade de peças é:", pieces)
	print("A quantidade de peças para abrir é:", pieces_to_open)
		
	
	


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		print("Activator: Estou colidindo como player")
		can_change = true
		body.can_interact()
		need_pieces_hud.visible = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	print("Activator: Não estou colidindo com o player")
	can_change = false
	player.cant_interact()
	need_pieces_hud.visible = false

func get_wall_complete_status():
	return wall_complete
	
