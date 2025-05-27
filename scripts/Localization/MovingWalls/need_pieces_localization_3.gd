extends Node

@onready var label: Label = $"../PiecesWallHUD/Label"
@onready var insuficient_pieces: Label = $"../PiecesWallHUD/Peças Insuficientes"
@onready var need_pieces: Label = $"../NeedPiecesHUD/NeedPieces"


func _process(delta: float) -> void:
	need_pieces.text = tr("NEED")
	label.text = tr("WALL_CONSTRUCTED")
	insuficient_pieces.text = tr("INSUFICIENT_PIECES")
