extends Node2D

var UP = []
var DOWN = []
var LEFT = []
var RIGHT = []

var score #score counter
var current_next = [10,20]
var wait_times = [2,3,4]

var set_speed = 100

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
			"8" : "res://Scenes/Truck_C.tscn"
}

var direction = ["Left","Right","Up","Down"]

var ROTATE = {"Left": PI/2,"Right" : -PI/2,"Up" : PI,"Down" : 0}# to rotate sprite and collision

# Toggle Start/Stop of vehicle in specific road
var toggle_up = 1
var toggle_down = 1
var toggle_left = 1
var toggle_right = 1

var state = true#to detect pause

# Start Timer
func _ready():
	score = -5
	$Timer.start()

func _on_Timer_timeout(): #to spawn vehicles
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

func _process(delta):
	score += delta #scoring
	get_input()# Update user input at each frame
	if score > current_next[0] and score <= 200: #speed controller according to score
		_speed_increase(current_next[1])
		current_next[0] = current_next[1]
		current_next[1] = current_next[1] + 10

# User Input Function
func get_input():
	if Input.is_action_just_pressed("pause"): #if p is pressed
		var pause = load("res://Scenes/Pause.tscn").instance()
		if state:
			add_child(pause)
			state = false
		else:
			state = true
	
	if Input.is_action_just_pressed("ui_up"):
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
func get_existing_cars(direction_name): #get current running vehicles in given direction
	var children = get_children()
	var children_cars = []
	for i in children:
		if i.name.begins_with("@Car"+direction_name) or i.name.begins_with("Car"+direction_name):
			if !(i.release): #if car not crossed the junction
				children_cars.append(i)
	return children_cars

func game_quit(pos): #quit or replay
	var explode = load("res://Scenes/Explode.tscn").instance()
	var replay = load("res://Scenes/Replay.tscn").instance()
	explode.set_position(pos)
	add_child(explode)
	print(score," seconds")
	SaveLoad.add_latest_score(score)
	SaveLoad._save_score(score)
	add_child(replay)

func _speed_increase(score_sec): #updating the speed and spawn timer according to score
	randomize()
	match score_sec:
		20 : 
			set_speed = 120
		30 :
			set_speed = 125
			$Timer.wait_time = wait_times[randi() % wait_times.size()]
		40 : 
			set_speed = 130
			$Timer.wait_time = wait_times[randi() % wait_times.size()]
		50 :
			set_speed = 135
			$Timer.wait_time = wait_times[randi() % wait_times.size()]
		60 : 
			set_speed = 140
			$Timer.wait_time = wait_times[randi() % wait_times.size()]
		70 : 
			set_speed = 150
			$Timer.wait_time = wait_times[randi() % wait_times.size()]
		80 : 
			set_speed = 160
			$Timer.wait_time = wait_times[randi() % wait_times.size()]
		_ :
			set_speed = int(rand_range(170,190))
			$Timer.wait_time = wait_times[randi() % wait_times.size()]

