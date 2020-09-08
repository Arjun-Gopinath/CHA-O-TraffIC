extends Node2D

var UP = []
var DOWN = []
var LEFT = []
var RIGHT = []

var cars = {"0" : "res://Scenes/Audi.tscn",
			"1" : "res://Scenes/BMW.tscn",
			"2" : "res://Scenes/Audi_2.tscn",
			"3" : "res://Scenes/Chevrolet.tscn",
			"4" : "res://Scenes/DeLorean.tscn",
			"5" : "res://Scenes/Ferrari.tscn",
			"6" : "res://Scenes/Ford.tscn",
			"7" : "res://Scenes/Truck_A.tscn",
			"8" : "res://Scenes/Truck_B.tscn"
}#vehicle scenes to spawn
var direction = ["Left","Right","Up","Down"]

var ROTATE = {"Left": PI/2,"Right" : -PI/2,"Up" : PI,"Down" : 0}#rotate sprite only dictionary

var toggle_up = 1#for toggling
var toggle_down = 1#the
var toggle_left = 1#pausing of
var toggle_right = 1#vehicle at certain position

func _ready():
	print(deg2rad(0.0))
	$Timer.start()

func _on_Timer_timeout():
	var temp_direction = direction.duplicate()
	var car
	for i in direction.size():
		randomize()
		var scene = str(temp_direction[0])
		car = load(cars[str(randi() % cars.size())]).instance()
		car.name = "Car"+scene
		car.get_node("Sprite").rotation = ROTATE[scene]
		var position_node = get_node(scene)
		car.position = position_node.position
		car.direction_to = temp_direction[0]
		add_child(car)
		temp_direction.remove(0)
		
func _process(delta):
	get_input()

func get_input():#inputs
	if Input.is_action_just_pressed("ui_up"):
		if toggle_up==1:
			UP = get_existing_cars("Up")
			for i in UP:
				i.stop_movement()
			toggle_up = 0
		else:
			for i in UP:
				i.restart_movement()
			toggle_up = 1
			UP.clear()
	elif Input.is_action_just_pressed("ui_down"):
		if toggle_down==1:
			DOWN = get_existing_cars("Down")
			for i in DOWN:
				i.stop_movement()
			toggle_down = 0
		else:
			for i in DOWN:
				i.restart_movement()
			toggle_down = 1
			DOWN.clear()
	elif Input.is_action_just_pressed("ui_right"):
		if toggle_right==1:
			RIGHT = get_existing_cars("Right")
			for i in RIGHT:
				i.stop_movement()
			toggle_right = 0
		else:
			for i in RIGHT:
				i.restart_movement()
			toggle_right = 1
			RIGHT.clear()
	elif Input.is_action_just_pressed("ui_left"):
		if toggle_left==1:
			LEFT = get_existing_cars("Left")
			for i in LEFT:
				i.stop_movement()
			toggle_left = 0
		else:
			for i in LEFT:
				i.restart_movement()
			toggle_left = 1
			LEFT.clear()

func _on_Area2D_body_entered(body):
	body.release = true
	body.move = true

func get_existing_cars(direction_name):
	var children = get_children()
	var children_cars = []
	for i in children:
		if i.name.begins_with("@Car"+direction_name) or i.name.begins_with("Car"+direction_name):
			if !(i.release):
				children_cars.append(i)
	return children_cars