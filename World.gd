extends Node2D


func _on_EndArea_body_entered(body):
	$AudioStreamPlayer.stop()
	$Slutmusik.play()
	$YSort/EndArea.queue_free()


func _on_Timer_timeout():
	$Instructions.set_deferred("visible", false)
