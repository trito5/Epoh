extends Node2D

var animation_triggered = false
var show_text = false

func _process(delta):
	if not animation_triggered:
		$Epoh.play("default")
		animation_triggered = true
	if $Epoh.position.y > 90:
		$Epoh.position.y = $Epoh.position.y - 20 * delta
	elif show_text == false: 
		show_text = true
		$FinsihText.set_deferred("visible", true)
		$Enter.set_deferred("visible", true)
		
	if Input.is_action_just_released("play"):
		get_tree().get_root().get_node("Global").set_hope(80)
		get_tree().change_scene("res://Menu.tscn")

