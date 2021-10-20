extends KinematicBody2D

func _on_hurtbox_area_entered(area):
	if area.name == "sword":
		playDead()

func playDead():
	$AnimatedSprite.queue_free()
	$AnimatedBlood.play()
	$AnimatedBlood.set_deferred("visible", true)
	$AudioStreamPlayer.play()
	$CollisionShape2D.queue_free()
	$hurtbox.queue_free()
