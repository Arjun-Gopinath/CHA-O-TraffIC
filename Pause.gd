extends Control

func _ready():
	print("paused")
	get_tree().paused = true

func _process(delta):
	get_input()
	pass
	
func get_input():
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = false
		queue_free()
