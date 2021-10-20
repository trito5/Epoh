extends KinematicBody2D

var hit = 2
var player = null
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var dead = false
const SPEED = 800
var startPosition = position
var stopPosition = Vector2(startPosition.x + 100, startPosition.y)
#var timer = 0
var direction = 1
var life = 2
var intersects = false
var switch = false

func _physics_process(delta):
	velocity = Vector2.ZERO
	#timer += 1
	if player and not dead:
		velocity = position.direction_to(player.position) * SPEED * 2 * delta
		
	elif not dead:
		if switch:
			direction = -direction
			switch = false
		
		velocity.x = direction * SPEED * delta
	
	if not dead:
		display_direction(velocity.x)
		knockback = knockback.move_toward(Vector2.ZERO, 1200 * delta)
		knockback = move_and_slide(knockback)
		velocity = move_and_slide(velocity)
	

func display_direction(direction):
	if (direction < 0):
		$AnimatedSprite.set_deferred("flip_h", false)
	else: 
		$AnimatedSprite.set_deferred("flip_h", true)

func _on_hurtbox_area_entered(area):
	if area.name == "sword":
		life -= 1
		if life < 1 :
			play_dead()
		else:
			knockback = area.knockback_vector * 200
			
	elif area.name == "smasher":
		get_tree().get_root().get_node("World").get_node("Message").show_bear_message()
		$AudioNope.play()

func _on_hitbox_body_entered(player):
	player.set_life(hit)
	intersects = true
	$TimerAttack.start()
	
func _on_hitbox_body_exited(body):
	$TimerAttack.stop()
	intersects = false

func _on_TimerAttack_timeout():
	player.set_life(hit)

func _on_Area2D_body_entered(body):
	player = body

func _on_Area2D_body_exited(body):
	player = null

func play_dead():
	dead = true
	$AudioHit.play()
	$AnimatedBlood.set_deferred("visible", true)
	$AnimatedBlood.play()
	$CollisionShape2D.queue_free()
	$hitbox.queue_free()
	$hurtbox.queue_free()
	$Area2D.queue_free()
	$AnimatedSprite.queue_free()


func _on_TimerDestination_timeout():
	switch = true
