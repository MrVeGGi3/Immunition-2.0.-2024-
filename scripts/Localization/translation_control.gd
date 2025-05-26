extends Control
@onready var option_button: OptionButton = $HBoxContainer/OptionButton
@onready var translation_label: Label = $HBoxContainer/TranslationLabel
@onready var type_screen_control: Control = $"../TypeScreenControl"

const SETUP = "res://data/Setup.json"

var LANGUAGES : Dictionary = {
	str(tr("ENGLISH_LANG_NAME")) : "en",
	str(tr("PTBR_LANGUAGE_NAME")): "pt_BR"
}
var languages_array = ["en", "pt_BR"]

func _ready() -> void:
	add_selectable_languages()


func add_selectable_languages():
	for language in LANGUAGES:
		option_button.add_item(language)
	var actual_language = TranslationServer.get_locale()
	for i in languages_array.size():
		if languages_array[i] == actual_language:
			option_button.select(i)


func _on_option_button_item_selected(index: int) -> void:
	Global.language_mode = "selected"
	var actual_language = LANGUAGES.values()[index]
	TranslationServer.set_locale(actual_language)
	save_main_language_selected(actual_language)
	print("A linguagem agora é", actual_language)
	type_screen_control.update_window_language()

func _process(delta: float) -> void:
	translation_label.text = tr("LANGUAGE_TYPE")


func save_main_language_selected(language : StringName):
	var data = {
		"language_mode" : Global.language_mode,
		"language_selected" : language
	}
	
	var jsonData = JSON.stringify(data)
	var jsonFile = FileAccess.open(SETUP, FileAccess.WRITE)
	jsonFile.store_line(jsonData)
	jsonFile.close()
	
	
