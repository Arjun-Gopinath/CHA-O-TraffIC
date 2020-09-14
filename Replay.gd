extends CanvasLayer

var text1 = "TRY AGAIN \nYOU ARE NOT BE THE ONE THIS JUNCTION NEEDS...\nYOU ARE THE ONE THIS JUNCTION DESERVES...."
var text2 = "WELL DONE MY BOII... WELL DONE, BEAT YOURSELF NOW, AI??"

onready var newscore = get_node("Control/MarginContainer/VBoxContainer/Score")
onready var hscore = get_node("Control/MarginContainer/VBoxContainer/high")

func _ready():
	get_tree().paused=true
	hscore.text += str(SaveLoad.load_game_score()) + " sec\n"
	newscore.text += str(SaveLoad.get_latest_score()) + " sec\n"
	if SaveLoad.get_latest_score()>=SaveLoad.load_game_score():
		get_node("Control/MarginContainer/VBoxContainer/Score2").text = text2
	else:
		get_node("Control/MarginContainer/VBoxContainer/Score2").text = text1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Replay_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false
	queue_free()
