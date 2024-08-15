extends Control
#Botões de Opção
@onready var button_options = $"PhaseButtons/Opções"
@onready var button_menu = $"PhaseButtons/Menu"

#Botões de Fase
@onready var phase_1 = $"PhaseButtons/Tutorial(Base)/Phase1"
@onready var phase_2 = $"PhaseButtons/Level_1/Phase2"
@onready var phase_3 = $"PhaseButtons/Level_2/Phase3"
@onready var phase_4 = $"PhaseButtons/Level_3/Phase4"

#Cenas de Transicao
@onready var MENU = "res://scenes/HUD/menu.tscn"
@onready var TUTORIAL = "res://scenes/Levels/world.tscn"
@onready var LEVEL_1 = "res://scenes/Levels/level_1.tscn"
@onready var LEVEL_2 = "res://scenes/Levels/level_2.tscn"
@onready var LEVEL_3 = "res://scenes/Levels/level_3.tscn"
@onready var OPTIONS = "res://scenes/HUD/options_menu_pre_game.tscn"

#Labels dos Nomes
@onready var label_level_1 = $PhaseButtons/PhaseButtonsName/Title_Level_1/Label_Level_1
@onready var label_level_2 = $PhaseButtons/PhaseButtonsName/Title_Level_2/Label_Level_2
@onready var label_level_3 = $PhaseButtons/PhaseButtonsName/Title_Level_3/Label_Level_3

# Called when the node enters the scene tree for the first time.
func _ready():
	_define_phase_name()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _define_phase_name():
	label_level_1.text = "Nivel 1"
	label_level_2.text = "Nível 2"
	label_level_3.text = "Nível 3"
	
	
	
func _on_menu_pressed():
	get_tree().change_scene_to_file(MENU)

func _on_phase_1_pressed():
	get_tree().change_scene_to_file(TUTORIAL)

func _on_phase_2_pressed():
	get_tree().change_scene_to_file(LEVEL_1)

func _on_phase_3_pressed():
	get_tree().change_scene_to_file(LEVEL_2)

func _on_phase_4_pressed():
	get_tree().change_scene_to_file(LEVEL_3)
	
func _on_options_2_pressed():
	get_tree().change_scene_to_file(OPTIONS)
