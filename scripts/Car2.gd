extends KinematicBody2D
var rng = RandomNumberGenerator.new()

#if Input.is_action_pressed("ui_right"):
#	motion.x = 100
#elif Input.is_action_just_released("ui_right"):
#	motion.x = 0
#if Input.is_action_pressed("ui_left"):
#	motion.x = -100
#elif Input.is_action_just_released("ui_left"):
#	motion.x = 0
#if Input.is_action_pressed("ui_up"):
#	motion.y = -100
#elif Input.is_action_just_released("ui_up"):
#	motion.y = 0	
#if Input.is_action_pressed("ui_down"):
#	motion.y = 100
#elif Input.is_action_just_released("ui_down"):
#	motion.y = 0
#move_and_slide(motion)

var motion = Vector2()
var speed = -50

func _ready():
	rng.randomize()
	speed = rng.randf_range(10,100)

func _process(delta):
	motion.x = -1*speed 
	move_and_slide(motion)
	pass
	

