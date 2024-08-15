extends Control

@onready var player = get_tree().get_first_node_in_group("player")
var phase_change = "res://scenes/HUD/level_selection.tscn"
var menu = "res://scenes/HUD/menu.tscn"
@export var score_time_scale = 10.0
@export var time_breaker = 100.0
#labels:
@onready var level_number = $LevelNumber
@onready var conclusion_message = $ConclusionMessage
@onready var pontuation_criteria_i = $PontuationCriteriaI
@onready var pontuation_criteria_ii = $PontuationCriteriaII
@onready var pontuation_criteria_iii = $PontuationCriteriaIII
@onready var percentage_i = $PercentageI
@onready var percentage_ii = $PercentageII
@onready var percentage_iii = $PercentageIII
@onready var score_i = $"Score I"
@onready var score_ii = $"Score II"
@onready var score_iii = $"Score III"
var pont_1
var pont_2
var pont_3
var actual_score_i = 0
var actual_score_ii = 0
var actual_score_iii = 0




func _ready():
	visible = false

func _on_go_to_menu_pressed():
	get_tree().change_scene_to_file(menu)

func level_finished(lvl : int, message : String, c1 : String, c2 : String, c3 : String):
	level_number.text = str(lvl)
	conclusion_message.text = message
	pontuation_criteria_i.text = c1
	pontuation_criteria_ii.text = c2
	pontuation_criteria_iii.text = c3
	
func count_score_lvl_1(inf_cells, total_cells, kill_enemies, total_enemies, player_life, max_life):
	var score_1 = floori(inf_cells/total_cells * 100)
	var score_2 = floori(kill_enemies/total_enemies * 100)
	var score_3 = floori(player_life/max_life * 100)
	percentage_i.text = str(score_1) + "%"
	percentage_ii.text = str(score_2) + "%"
	percentage_iii.text = str(score_3) + "%"
	pont_1 = score_1 * 10
	pont_2 = score_2 * 10
	pont_3 = score_3 * 10


func score_animation_1():
	var limit_score = pont_1
	if actual_score_i < pont_1:
		actual_score_i += 10

func score_animation_2():
	var limit_score = pont_2
	if actual_score_ii < pont_2:
		actual_score_ii += 10

func score_animation_3():
	var limit_score = pont_3
	if actual_score_iii < pont_3:
		actual_score_iii += 10

func _process(delta):
	score_i.text = str(actual_score_i)
	score_ii.text = str(actual_score_ii)
	score_iii.text = str(actual_score_iii)
	
	

	
	
