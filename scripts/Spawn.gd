extends Node2D

var UP = []
var DOWN = []
var LEFT = []
var RIGHT = []

var score

var time = [0,0,0,0]
# block/go texture
var block = preload("res://sprites/block.png")
var go = preload("res://sprites/go.png")

# Sprite for each direction's block notifier 
onready var LBlock = get_node("LeftBlock")
onready var UBlock = get_node("UpBlock")
onready var RBlock = get_node("RightBlock")
onready var DBlock = get_node("DownBlock")

# Vehicle scenes to spawn
var cars = {"0" : "res://Scenes/Audi.tscn",
			"1" : "res://Scenes/BMW.tscn",
			"2" : "res://Scenes/Audi_2.tscn",
			"3" : "res://Scenes/Chevrolet.tscn",
			"4" : "res://Scenes/DeLorean.tscn",
			"5" : "res://Scenes/Ferrari.tscn",
			"6" : "res://Scenes/Ford.tscn",
			"7" : "res://Scenes/Truck_A.tscn",
			"8" : "res://Scenes/Truck_B.tscn"
}

var direction = ["Left","Right","Up","Down"]

var ROTATE = {"Left": PI/2,"Right" : -PI/2,"Up" : PI,"Down" : 0}#rotate sprite only dictionary

# Toggle Start/Stop of vehicle in specific road
var toggle_up = 1
var toggle_down = 1
var toggle_left = 1
var toggle_right = 1

# Start Timer
func _ready():
	score = 0
	$Timer.start()
	$ScoreCounter.start()

func _on_Timer_timeout():
	var temp_direction = direction.duplicate()
	var car
	for i in direction.size():
		randomize()
		var scene = str(temp_direction[0])
		car = load(cars[str(randi() % cars.size())]).instance()
		car.name = "Car"+scene
		car.get_node("Sprite").rotation = ROTATE[scene]
		car.get_node("CollisionShape2D").rotation = ROTATE[scene]
		var position_node = get_node(scene)
		car.position = position_node.position
		car.direction_to = temp_direction[0]
		add_child(car)
		temp_direction.remove(0)

# Update user input at each frame		
func _process(_delta):
	score+=_delta
	get_input()

# User Input Function
func get_input():
	if Input.is_action_just_pressed("ui_up"):
		print(get_viewport().size)
		if toggle_up==1:
			UP = get_existing_cars("Up")
			for i in UP:
				i.stop_movement()
			toggle_up = 0
			UBlock.set_texture(block)	
		else:
			for i in UP:
				i.restart_movement()
			toggle_up = 1
			UP.clear()
			UBlock.set_texture(go)
	elif Input.is_action_just_pressed("ui_down"):
		if toggle_down==1:
			DOWN = get_existing_cars("Down")
			for i in DOWN:
				i.stop_movement()
			toggle_down = 0
			DBlock.set_texture(block)
		else:
			for i in DOWN:
				i.restart_movement()
			toggle_down = 1
			DOWN.clear()
			DBlock.set_texture(go)
	elif Input.is_action_just_pressed("ui_right"):
		if toggle_right==1:
			RIGHT = get_existing_cars("Right")
			for i in RIGHT:
				i.stop_movement()
			toggle_right = 0
			RBlock.set_texture(block)
		else:
			for i in RIGHT:
				i.restart_movement()
			toggle_right = 1
			RIGHT.clear()
			RBlock.set_texture(go)
	elif Input.is_action_just_pressed("ui_left"):
		if toggle_left==1:
			LEFT = get_existing_cars("Left")
			for i in LEFT:
				i.stop_movement()
			toggle_left = 0
			LBlock.set_texture(block)
		else:
			for i in LEFT:
				i.restart_movement()
			toggle_left = 1
			LEFT.clear()
			LBlock.set_texture(go)

# Vehicle entered screen
func _on_Area2D_body_entered(body):
	body.release = true
	body.move = true

# Exited vehicles
func get_existing_cars(direction_name):
	var children = get_children()
	var children_cars = []
	for i in children:
		if i.name.begins_with("@Car"+direction_name) or i.name.begins_with("Car"+direction_name):
			if !(i.release):
				children_cars.append(i)
	return children_cars

func game_quit():
	while score>60:
		if score>3600:
			time[0]+=1
			score-=3600
		elif score>60:
			time[1]+=1
			score-=60
	time[2] = int(score)
	score -= int(score)
	time[3] = score
	print("Time taken: " +str(time[0]) +" hours, "+ str(time[1]) +" minutes , " 
	+ str(time[2]) +" seconds, "+ str(time[3]) +" milliseconds")
	get_tree().quit()


func _on_ScoreCounter_timeout():
	pass
