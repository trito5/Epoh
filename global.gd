extends Node

var hope = 80
var firstTime = true

func set_hope(input):
	hope = input
	firstTime = false
	
func get_hope():
	return hope
	
func get_first_time():
	return firstTime
