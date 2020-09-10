extends Node

func _on_Start_pressed():
	Transition.fade_to("res://Main.tscn")
	pass # Replace with function body.

func _on_Quit_pressed():
	get_tree().quit()
	pass
	
