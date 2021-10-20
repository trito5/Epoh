extends KinematicBody2D

var hit = 0
var HIT_LIMIT = 1
func _on_hurtbox_area_entered(area):
	if area.name == "sword":
		if hit == HIT_LIMIT:
			playDead()
		else: 
			hit = hit + 1
			$Hit.play()

func playDead():
	$AnimatedSprite.queue_free()
	$AnimatedBlood.play()
	$AnimatedBlood.set_deferred("visible", true)
	$AudioStreamPlayer.play()
	$CollisionShape2D.queue_free()
	$hurtbox.queue_free()
