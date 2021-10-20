extends Control

var hope_change = 1
var MAX_RECT_SIZE = 80
var alarm_on = false
var is_punishing = false

func _ready():	
	$YSort/HopeMeter.rect_size.x = get_tree().get_root().get_node("Global").get_hope()
	
	
func _process(delta):
	if $YSort/HopeMeter.rect_size.x < MAX_RECT_SIZE and hope_change > 0:
		$YSort/HopeMeter.rect_size.x = $YSort/HopeMeter.rect_size.x + hope_change * delta
	elif $YSort/HopeMeter.rect_size.x > 0 and hope_change < 0:
		$YSort/HopeMeter.rect_size.x = $YSort/HopeMeter.rect_size.x + hope_change * delta
	elif $YSort/HopeMeter.rect_size.x == 0:
		get_tree().change_scene("res://ZeroHope.tscn")
	
	$YSort/CheckUpTimer.rect_size.x = $YSort/CheckUpTimer.rect_size.x - 2 * delta
	if $YSort/CheckUpTimer.rect_size.x > 55:
		$YSort/CheckUpTimer.color = Color(0, 1, 0, 1)
	elif $YSort/CheckUpTimer.rect_size.x > 40:
		$YSort/CheckUpTimer.color = Color(0.68, 1, 0.18, 1)
	elif $YSort/CheckUpTimer.rect_size.x > 20:
		$YSort/CheckUpTimer.color = Color(1, 1, 0, 1)
	elif $YSort/CheckUpTimer.rect_size.x > 10:
		$YSort/CheckUpTimer.color = Color(1, 0.65, 0, 1)
	else:
		$YSort/CheckUpTimer.color = Color(1, 0, 0, 1)
	
	if $YSort/CheckUpTimer.rect_size.x == 0:
		check_up_time()
		
	if alarm_on:
		if hope_change > 0 and not is_punishing:
			punish_player()

func punish_player():
	is_punishing = true
	get_tree().get_root().get_node("World").get_node("YSort").get_node("epoh").set_punishing(true)
	$PunishTimer.start()
	$MobMsgCheckup.set_deferred("visible", false)
	$Message.set_deferred("visible", true)
	
func check_up_time():
	if not alarm_on:
		$YSort/CheckUpText.set_deferred("visible", true)
		$MobMsgCheckup.set_deferred("visible", true)
		alarm_on = true
		$Alarm.play()
		$CheckUpTimer.start()

func change_hope(isPlayerInWorkArea):
	if isPlayerInWorkArea:
		hope_change = -2
	else:
		hope_change = 0.2

func take_hit(value):
	if $YSort/HopeMeter.rect_size.x - value > 0:
		$YSort/HopeMeter.rect_size.x = $YSort/HopeMeter.rect_size.x - value
	else:
		get_tree().change_scene("res://ZeroHope.tscn")
		
func _on_CheckUpTimer_timeout():
	if not is_punishing:
		$YSort/CheckUpTimer.rect_size.x = MAX_RECT_SIZE
		$Alarm.stop()
		$YSort/CheckUpText.set_deferred("visible", false)
		alarm_on = false
		$MobMsg.set_deferred("visible", true)
		$MobMsgTimer.start()
	$CheckUpTimer.stop()
	$MobMsgCheckup.set_deferred("visible", false)

func _on_PunishTimer_timeout():
	$Alarm.stop()
	alarm_on = false
	is_punishing = false
	$Message.set_deferred("visible", false)
	if get_tree().get_root().get_node("Global").get_hope() > 20:
		get_tree().get_root().get_node("Global").set_hope($YSort/HopeMeter.rect_size.x - 20)
		get_tree().change_scene("res://PreScene.tscn")
	else:
		get_tree().change_scene("res://ZeroHope.tscn")
	


func _on_MobMsgTimer_timeout():
	$MobMsg.set_deferred("visible", false)
