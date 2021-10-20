extends KinematicBody2D

var velocity = Vector2.ZERO
var SPEED = 60
const ACCELERATION = 50
var friction = 2000
var hasWon = false
var is_punishing = false

enum {
	MOVE,
	SMASH,
	ATTACK
}

var state = MOVE

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var startPosition = self.global_position

func _ready():
	is_punishing = false

func _physics_process(delta):
	if Input.is_action_just_pressed("turbo"):
		toggle_turbo()
	match state:
		MOVE:
			state_move(delta)
		ATTACK:
			state_attack(delta)
			
func toggle_turbo():
	if SPEED == 60:
		SPEED = 90
	else:
		SPEED = 60

func state_move(delta):
	if not is_punishing:
		var input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") 
		input_vector = input_vector.normalized()
		
		if input_vector != Vector2.ZERO:
			$Position2D/sword.knockback_vector = input_vector
			animationTree.set("parameters/idle/blend_position", input_vector)
			animationTree.set("parameters/run/blend_position", input_vector)
			animationTree.set("parameters/smash/blend_position", input_vector)
			animationTree.set("parameters/attack/blend_position", input_vector)
			animationState.travel("run")
			velocity = velocity.move_toward(input_vector * SPEED, ACCELERATION)

		else:
			animationState.travel("idle")
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
		velocity = move_and_slide(velocity)
			
		if Input.is_action_just_pressed("attack"):
			state = ATTACK
			
		if Input.is_action_just_released("cheat") and is_punishing == false:
			self.position = startPosition
	
func state_attack(delta):
	velocity = Vector2.ZERO
	animationState.travel("attack")
	
func attack_animation_done():
	state = MOVE

func entered_work_area(value):
	get_tree().get_root().get_node("World").get_node("Display/Control").change_hope(value)
	
func _on_AnimatedSprite_animation_finished():
	queue_free()

func mob_hit():
	if is_punishing == false:
		get_tree().get_root().get_node("World").get_node("Display/Control").take_hit(20)
		$AudioTakeDamage.play()

func set_punishing(value):
	is_punishing = value
