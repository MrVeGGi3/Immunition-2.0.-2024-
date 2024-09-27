extends RichTextLabel
@export var spaces_number = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	append_title_line("Arte 2D, UI, Animação")
	append_next_line()
	append_desc_line("Daniel Marto da Silva")
	append_empty_space()
	append_title_line("Game Design, Arte 3D e Level Design")
	append_next_line()
	append_desc_line("Lucas Camilo dos Reis")
	append_empty_space()
	append_title_line("Programação, Sonografia")
	append_next_line()
	append_desc_line("Matheus Veras Soares")
	append_empty_space()
	append_title_line("Músicas Utilizadas")
	append_next_line()
	append_copyright_item("Infraction", "Game Boy")
	append_next_line()
	append_copyright_item("Vlad Gluschenko", "When the Lights Go On")
	append_next_line()
	append_copyright_item("Ultrawave", "Oceandive")
	append_next_line()
	append_copyright_item("San Junipero", "Infraction")
	append_empty_space()
	append_title_line("Agradecimentos Especiais")
	
	
	
func append_title_line(title : String):
	append_text("[font_size=20][center][b][color=orange]%s[/color][/b][/center][/font_size]" % [title])

func append_desc_line(description : String):
	append_text("[font_size=20][center][color=white]%s[/color][/center][/font_size]" % [description])
	
func append_copyright_item(author : String, piece : String):
	append_text("[font_size=20][center][color=green]%s[/color]: %s[/center][/font_size]" % [author, piece])
	
func append_next_line():
	append_text("\n")
	
func append_empty_space():
	for i in range(spaces_number):
		append_text("\n")	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
