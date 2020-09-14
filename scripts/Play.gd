extends Node

var transition_node
#var controlnode

func _ready():
	get_node("AnimationPlayer").play("move")
	var score = SaveLoad.load_game_score()
	print("Saved Score : ",score," Seconds ")
	transition_node = load("res://Scenes/Transition.tscn").instance() #made an instance for transition scene
	pass

func _on_Start_pressed():
	#transition scene node added
	add_child(transition_node)

func _on_Quit_pressed():
	get_tree().quit()


func _on_Controls_pressed():
	var controlnode = load("res://Scenes/Controls.tscn").instance()
	add_child(controlnode)
	pass # Replace with function body.
