extends Node

var transition_node #main game scene
var controlnode

onready var hiscore = get_node("MarginContainer2/ColorRect/ScoreText")
onready var score = SaveLoad.load_game_score()

func _ready():
	get_node("AnimationPlayer").play("move")
	if score==0:
		hiscore.text = "FIRST TIME ??? HUH..."
	else:
		hiscore.text = "HIGH SCORE : " + str(score) + " SEC"
	transition_node = load("res://Scenes/Transition.tscn").instance() #made an instance for transition scene

func _on_Start_pressed():
	add_child(transition_node)

func _on_Quit_pressed():
	get_tree().quit()

func _on_Controls_pressed():
	controlnode = load("res://Scenes/Controls.tscn").instance()
	controlnode.get_node("Back").connect("pressed",self,"_back_pressed")
	add_child(controlnode)

func _back_pressed():
	if controlnode:
		controlnode.queue_free()
