extends CanvasLayer

func _ready():
	get_tree().paused=true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Replay_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false
	queue_free()
