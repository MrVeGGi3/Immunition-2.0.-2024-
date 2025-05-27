extends Node
@onready var need_pieces: Label = $"../MovingWalls4/NeedPiecesHUD/NeedPieces"
@onready var label: Label = $"../MovingWalls4/PiecesWallHUD/Label"
@onready var insuficient_pieces : Label = $"../MovingWalls4/PiecesWallHUD/Peças Insuficientes"


func _process(delta: float) -> void:
	need_pieces.text = tr("NEED")
	label.text = tr("WALL_CONSTRUCTED")
	insuficient_pieces.text = tr("INSUFICIENT_PIECES")
