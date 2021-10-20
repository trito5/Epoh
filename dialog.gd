extends YSort

var stepper = 0
var paus = true
var animation_triggered = false

onready var nodes = [$dia_what, $dia_e_epoh, $dia_keeper, $dia_e_dark, $dia_mine, $dia_e_drone, $dia_important]


func _process(delta):
	if Input.is_action_just_pressed("attack"):
		get_tree().change_scene("res://World.tscn")
	if Input.is_action_just_pressed("play") and not paus:
		if stepper == nodes.size():
			for dia in nodes:
				dia.set_deferred("visible", false)
			$dia_e_where.set_deferred("visible", false)
			$Timer2.start()
			$epoh.set_deferred("visible", false)
			$Mob.set_deferred("visible", false)
			$Enter.set_deferred("visible", false)
		else:
			nodes[stepper].set_deferred("visible", true)
			stepper = stepper + 1
			if stepper % 2 == 0:
				$dia_empty.set_deferred("visible", true)
			else:
				$dia_empty.set_deferred("visible", false)
				
	if not animation_triggered:
		$epoh.play("default")
		animation_triggered = true
	
	if ($Mob.position.x > 90):
		$Mob.position.x = $Mob.position.x - 70 * delta


func _on_Timer_timeout():
	$dia_e_where.set_deferred("visible", true)
	paus = false
	$Enter.set_deferred("visible", true)

func _on_Timer2_timeout():
	$AudioStreamPlayer.stop()
	get_tree().change_scene("res://PreScene.tscn")
