extends Control

func _input(event):
	if Input.is_action_just_pressed("pause"):
		var new_state = not get_tree().paused
		get_tree().paused = new_state
		visible = new_state
