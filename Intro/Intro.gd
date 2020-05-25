extends Node2D

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name):
		GD_global.goto_scene("res://Main/Main.tscn")
	pass
