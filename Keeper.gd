extends KinematicBody2D

var MAX_HITS = 3
var hits = 0
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
const SPEED = 800
var startPosition = position
var stopPosition = Vector2(startPosition.x + 100, startPosition.y)
var direction = 1
var switch = false
var player = null
var alive = true

func _physics_process(delta):
	velocity = Vector2.ZERO
	if alive:
		if player:
			velocity = position.direction_to(player.position) * SPEED * 2 * delta
		else:
			
			if switch:
				direction = -direction
				switch = false
			
			velocity.x = direction * SPEED * delta
		
		display_direction(velocity.x)
		knockback = knockback.move_toward(Vector2.ZERO, 1200 * delta)
		knockback = move_and_slide(knockback)
		velocity = move_and_slide(velocity)
	
func display_direction(direction):
	if (direction > 0):
		$AnimatedSprite.set_deferred("flip_h", false)
	else: 
		$AnimatedSprite.set_deferred("flip_h", true)

func _on_hurtbox_area_entered(area):
	if area.name == "sword":
		if hits == MAX_HITS:
			$Die.play()
			play_dead_scene()
		else:
			knockback = area.knockback_vector * 400
			$Hit.play()
			hits = hits + 1

func play_dead_scene():
	$DieAnimation.play()
	$DieAnimation.set_deferred("visible", true)
	$AnimatedSprite.queue_free()
	$CollisionShape2D.queue_free()
	$hitbox.queue_free()
	$hurtbox.queue_free()
	alive = false

func _on_Timer_timeout():
	switch = true

func _on_HuntArea_body_entered(body):
	player = body

func _on_HuntArea_body_exited(body):
	player = null


func _on_hitbox_body_entered(body):
	body.mob_hit()
