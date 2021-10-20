extends RigidBody2D


func _ready():
	pass

func _on_Area2D_body_entered(body):
	$Message.set_deferred("visible", true)


func _on_Area2D_body_exited(body):
	$Message.set_deferred("visible", false)
