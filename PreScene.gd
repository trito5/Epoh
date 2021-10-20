extends Node2D

var rng = RandomNumberGenerator.new()
func _ready():
	rng.randomize()
	var number = rng.randi_range(1, 6)
	if number == 1:
		$Quote1.set_deferred("visible", true)
	elif number == 2:
		$Quote2.set_deferred("visible", true)
	elif number == 3:
		$Quote3.set_deferred("visible", true)
	elif number == 4:
		$Quote4.set_deferred("visible", true)
	elif number == 5:
		$Quote5.set_deferred("visible", true)
	elif number == 6:
		$Quote6.set_deferred("visible", true)

func _physics_process(delta):
	pass
	#if Input.is_action_just_pressed("play"):
	#	get_tree().change_scene("res://World.tscn")

func _on_Timer_timeout():
	get_tree().change_scene("res://World.tscn")
