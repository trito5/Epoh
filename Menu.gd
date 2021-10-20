extends Node2D
var hasShownGameStory = false

func _ready():
	$AudioMain.play()

func _physics_process(delta):
	if Input.is_action_just_pressed("play"):
		get_tree().change_scene("res://dialog.tscn")

