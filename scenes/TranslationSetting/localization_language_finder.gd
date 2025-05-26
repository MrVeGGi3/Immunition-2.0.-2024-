extends Node

const SETUP = "res://data/Setup.json"

func _ready() -> void:
	load_saved_lanaguage()
	set_main_language()


func set_main_language():
	if Global.language_mode == "automatic":
		var preferred_language = OS.get_locale_language()
		TranslationServer.set_locale(preferred_language)
	elif Global.language_mode != "automatic" and Global.language_mode != "selected":
		TranslationServer.set_locale("en")
		

func load_saved_lanaguage():
	var jsonFile = FileAccess.open(SETUP, FileAccess.READ)
	var jsonData = jsonFile.get_as_text()
	jsonFile.close()
	var data = JSON.parse_string(jsonData)
	
	if data == null:
		return
	else:
		Global.language_mode = data.language_mode
		TranslationServer.set_locale(data.language_selected)
