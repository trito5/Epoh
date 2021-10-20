extends Sprite

func _ready():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if body.name == "epoh":
		get_tree().change_scene("res://Winning.tscn")
