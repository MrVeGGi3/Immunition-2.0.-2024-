class_name CellSpawner
extends Node3D

var cell = preload("res://scenes/Characters/Cell.tscn")
var cells_created = Global.cells_in_scene

@export var to_instantiate = cell
@export var maximum_cells = 3
# Called when the node enters the scene tree for the first time.
var can_create_cells = false
@onready var create_cell_instance = $CreateCellInstance

func spawnCells():
	if cells_created > maximum_cells:
		return
	var instance = cell.instantiate()
	instance.global_position = global_position + Vector3(0,1,0) 
	get_parent().add_child(instance)
	cells_created += 1
	create_cell_instance.start()
	print("Célula Spawnado")
	
func _on_timer_timeout():
	spawnCells()
	
func _process(_delta):
	pass
	
	
	
