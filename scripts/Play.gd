extends Node

var transition_node

func _ready():
	get_node("AnimationPlayer").play("move")
	var score = SaveLoad.load_game_score()
	print(score," Seconds ")
	#made an instance for transition scene
	transition_node = load("res://Scenes/Transition.tscn").instance()
	pass

func _on_Start_pressed():
	#transition scene node added
	add_child(transition_node)


func _on_Quit_pressed():
	get_tree().quit()
