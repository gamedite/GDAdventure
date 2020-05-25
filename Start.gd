extends Node2D

func _ready():
	GD_global.GD_OSsize = OS.get_screen_size()
	GD_global.GD_size = get_viewport_rect().size
	GD_global.goto_scene("res://Intro/Intro.tscn")

