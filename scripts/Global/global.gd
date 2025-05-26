extends Node

##Sensitividade do Mouse
var mouse_sens = 0.5

@export_group("Booleanas de Controle do Tiro")
##Booleana de controle da pistol leucócito
var c_shoot = true
##Booleana de controle do rifle macrófago
var c_shoot_mf = false
##Booleana de controle do lança chamas neutrófilo
var c_shoot_nf = false
##Booleana de controle da Bazooka
var c_shoot_bz = false
@export_group("Booleanas de Controle do Simbolo selecionado")
##Booleana de checagem do simbolo de Triângulo está ativo
var m1_active = true
##Boolena de checagem do símbolo de Círculo está ativo
var m2_active = false
##Booleana de checagem do símbolo de Seta está ativo
var m3_active = false


##Controle da emissão de lança chamas
const CONTROL_BULLET_EMISSION = 2

##Checa se está pausado
var is_paused = false

@export_group("Calculo de Pontução")
#placar e pontuação
var contamined_cells : int = 0
var cells_in_scene : int = 0
var influenza_destroyed : int = 0
var infected_cells_destroyed : int = 0
var influenza_in_scene: int = 0
var pathogen_killed : int = 0 
var blue_pathogen_spawned : int = 0
var green_pathogen_spawned : int = 0
var red_pathogen_spawned : int = 0 
#Contagem de Objetos Coletados!
var extractors_collected : int = 0
var wall_piece : int = 0 
#Contagem se um objetivo foi alcançado
var is_enemies_destroyed = false
var pipes_destroyed : int
var score_index = 0

##Define o tipo de função da linguagem
var language_mode = "automatic"
