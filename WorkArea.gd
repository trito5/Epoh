extends Sprite

func _on_Area2D_body_entered(player):
	if player.name == "epoh":
		player.entered_work_area(true)

func _on_Area2D_body_exited(player):
	if player.name == "epoh":
		player.entered_work_area(false)


func _on_hurtbox_area_entered(area):
	$Hit.play()
