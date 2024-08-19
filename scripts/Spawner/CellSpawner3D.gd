class_name CellSpawner
extends Node3D

var cell = preload("res://scenes/Characters/Cell.tscn")


@export var to_instantiate = cell
@export var maximum_cells = 3
# Called when the node enters the scene tree for the first time.
var can_create_cells = false
@onready var create_cell_instance = $CreateCellInstance

func spawnCells():
	if Global.cells_in_scene > maximum_cells:
		return
	var instance = cell.instantiate()
	get_parent().add_child(instance)
	if instance.is_inside_tree():
		instance.global_position = global_position + Vector3(0,1,0) 
		Global.cells_in_scene += 1
		print("O número de células na cena é:", Global.cells_in_scene)
		create_cell_instance.start()
		print("Célula Spawnado")
	else:
		print("Célula não foi spawnada da maneira correta")
	
func _on_timer_timeout():
	spawnCells()
	
func _process(_delta):
	pass
	
	
	
