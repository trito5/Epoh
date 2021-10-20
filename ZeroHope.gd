extends Node2D


func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_released("play"):
		get_tree().get_root().get_node("Global").set_hope(80)
		get_tree().change_scene("res://Menu.tscn")
