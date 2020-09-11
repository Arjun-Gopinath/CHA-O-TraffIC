extends Node

var transition_node

func _ready():
	var score = SaveLoad.load_game_score()
	print("Saved Score : ",score," Seconds ")
	#made an instance for transition scene
	transition_node = load("res://Scenes/Transition.tscn").instance()
	pass


func _on_Start_pressed():
	#transition scene node added
	add_child(transition_node)


func _on_Quit_pressed():
	get_tree().quit()
