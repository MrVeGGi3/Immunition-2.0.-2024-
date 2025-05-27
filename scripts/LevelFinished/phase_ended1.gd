extends Control

@onready var player = get_tree().get_first_node_in_group("player")
var phase_change = "res://scenes/HUD/level_selection.tscn"
var menu = "res://scenes/HUD/menu.tscn"
@export var score_time_scale = 10.0
@export var time_breaker = 100.0
#labels:
@onready var level_number = $LevelNumber
@onready var conclusion_message = $ConclusionMessage
@onready var pontuation_criteria_i = $VBoxContainer/PontuationCriteriaI
@onready var pontuation_criteria_ii = $VBoxContainer/PontuationCriteriaII
@onready var pontuation_criteria_iii = $VBoxContainer/PontuationCriteriaIII
@onready var percentage_i = $VBoxContainer3/PercentageI
@onready var percentage_ii = $VBoxContainer3/PercentageII
@onready var percentage_iii = $VBoxContainer3/PercentageIII
@onready var score_i = $"VBoxContainer2/Score I"
@onready var score_ii = $"VBoxContainer2/Score II"
@onready var score_iii = $"VBoxContainer2/Score III"
@onready var animation_tree: AnimationPlayer = $AnimationTree
@onready var NextPhaseButton: Button = $GoToNextPhase
@onready var nível: Label = $Nível
@onready var go_to_menu: Button = $GoToMenu





var level_2 = "res://scenes/Levels/level_2.tscn"
var level_3 = "res://scenes/Levels/level_3.tscn"
var scenes = [level_2, level_3]


var pont_1
var pont_2
var pont_3
var actual_score_i = 0
var actual_score_ii = 0
var actual_score_iii = 0
var scenes_index



func _ready():
	visible = false
	animation_tree.speed_scale = 2.0

func _on_go_to_menu_pressed():
	get_tree().change_scene_to_file(menu)

func level_finished(lvl : int, message : String, c1 : String, c2 : String, c3 : String):
	level_number.text = str(lvl)
	conclusion_message.text = message
	pontuation_criteria_i.text = c1
	pontuation_criteria_ii.text = c2
	pontuation_criteria_iii.text = c3
	
func count_score_lvl_1(inf_cells : float, total_cells : float, kill_enemies : float, total_enemies : float , player_life : float, max_life : float):
	var score_1 = floori((1 - (inf_cells/total_cells)) * 100)
	var score_2 = float(kill_enemies/total_enemies * 100)
	var score_3 = floori(player_life/max_life * 100)
	var score_2_int = floori(score_2)
	percentage_i.text = str(score_1) + "%"
	percentage_ii.text = str(score_2_int) + "%"
	percentage_iii.text = str(score_3) + "%"
	pont_1 = score_1 * 10
	pont_2 = score_2_int * 10
	pont_3 = score_3 * 10
	animation_tree.play("score_animation")

func count_score_lvl_2(minutes : float, kill_enemies : float, player_life : float, maximum_time : int, total_enemies : int, max_life : int):
	var score_1 = floori((1 - (minutes/maximum_time)) * 100)
	var score_2 = floori((kill_enemies/total_enemies) * 100)
	var score_3 = floori((player_life/max_life) * 100)
	percentage_i.text = str(score_1) + "%"
	percentage_ii.text = str(score_2) + "%"
	percentage_iii.text = str(score_3) + "%"
	pont_1 = score_1 * 10
	pont_2 = score_2 * 10
	pont_3 = score_3 * 10
	animation_tree.play("score_animation")

func count_score_lvl_3(broken_pipes, total_pipes, kill_enemies, total_enemies, player_life, max_life):
	var pipes_relation = (broken_pipes/total_pipes)
	var score_1 = floori((1 - pipes_relation) * 100)
	var score_2 = floori((kill_enemies/total_enemies) * 100)
	var score_3 = floori((player_life/max_life) * 100)
	percentage_i.text = str(score_1) + "%"
	percentage_ii.text = str(score_2) + "%"
	percentage_iii.text = str(score_3) + "%"
	pont_1 = score_1 * 10
	pont_2 = score_2 * 10
	pont_3 = score_3 * 10
	animation_tree.play("score_animation")

func score_animation_1():
	if actual_score_i < pont_1:
		actual_score_i += 100 
	elif pont_1 - actual_score_i < 100:
		actual_score_i += 10
	elif actual_score_i > pont_1:
		actual_score_i = pont_1
	else:
		return

func score_animation_2():
	if actual_score_ii < pont_2:
		actual_score_ii += 100 
	elif pont_2 - actual_score_ii < 100:
		actual_score_ii += 10
	elif actual_score_ii > pont_2:
		actual_score_ii = pont_2
	else:
		return
func score_animation_3():
	if actual_score_iii < pont_3:
		actual_score_iii += 100 
	elif pont_3 - actual_score_iii < 100:
		actual_score_iii += 10	
	elif actual_score_iii > pont_3:
		actual_score_iii = pont_3
	else: 
		return
func _process(_delta):
	score_i.text = str(actual_score_i)
	score_ii.text = str(actual_score_ii)
	score_iii.text = str(actual_score_iii)
	scenes_index = Global.score_index
	nível.text = tr("LEVEL_CONCLUDED")
	NextPhaseButton.text = tr("NEXT_LEVEL_BUTTON")
	go_to_menu.text = tr("MENU_BUTTON")
	
	
	

func _on_go_to_next_phase_pressed() -> void:
	if scenes_index == 0:
		get_tree().change_scene_to_file(level_2)
	if scenes_index == 1:
		get_tree().change_scene_to_file(level_3)
	Global.score_index += 1

func _hide_button():
	NextPhaseButton.visible = false
