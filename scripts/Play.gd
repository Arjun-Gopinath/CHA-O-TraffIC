extends Node

func _ready():
	pass


func _on_Start_pressed():
	Transition.fade_to("res://Main.tscn")


func _on_Quit_pressed():
	get_tree().quit()
