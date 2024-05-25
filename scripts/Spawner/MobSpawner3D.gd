class_name Spawner
extends Node3D

var cell = preload("res://scenes/testing/Cell.tscn")
var cells_created = Global.cells_in_scene

# Called when the node enters the scene tree for the first time.

func spawnCells():
	if cells_created > 5:
		return
	var instance = cell.instantiate()
	instance.global_position = global_position + Vector3(0,1,0) 
	get_parent().add_child(instance)
	cells_created += 1
	
func _on_timer_timeout():
	spawnCells()
	
func _process(_delta):
	pass
	
	
	
