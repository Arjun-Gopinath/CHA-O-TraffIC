extends CanvasLayer

var text1 = "TRY AGAIN \nYOU ARE NOT THE ONE THIS JUNCTION NEEDS...\nBUT THE ONE THIS JUNCTION DESERVES...."
var text2 = "WELL DONE MY BOII... WELL DONE, BEAT YOURSELF NOW, AI??"

onready var newscore = get_node("Control/MarginContainer/VBoxContainer/Score")
onready var hscore = get_node("Control/MarginContainer/VBoxContainer/high")

func _ready():
	get_tree().paused=true
	newscore.align = 1
	newscore.valign = 1
	hscore.align = 1
	hscore.valign = 1
	hscore.text = "HIGHSCORE : "+ str(SaveLoad.load_game_score()) + " sec"
	newscore.text = "SCORE : " + str(SaveLoad.get_latest_score()) + " sec"
	if SaveLoad.get_latest_score()>=SaveLoad.load_game_score():
		get_node("Control/MarginContainer/VBoxContainer/Score2").text = text2
	else:
		get_node("Control/MarginContainer/VBoxContainer/Score2").text = text1

func _on_Replay_pressed():
	if get_tree().reload_current_scene() != 0:
		get_tree().quit()
	else:
		get_tree().paused = false
		queue_free()

func _on_MainMenu_pressed():
	if get_tree().change_scene("res://Start.tscn") != 0:
		get_tree().quit()
	else:
		get_tree().paused = false
		queue_free()
