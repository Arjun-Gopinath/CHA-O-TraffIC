extends KinematicBody2D

var direction_to = Vector2()
var speed = 100

var release : bool = false#if true , car crossed or crossing the junction
var move : bool = true

var DIRECTIONS = {"Left" : Vector2.RIGHT,"Right"  : Vector2.LEFT,
					"Up" : Vector2.DOWN,"Down"  : Vector2.UP
}

func _ready():
	if direction_to:
		$VisibilityNotifier2D.position = DIRECTIONS[direction_to] * -14
	
func _process(delta):
	if direction_to:
		if move:
			position += DIRECTIONS[direction_to] * speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func stop_movement():
	move = false
	pass
	
func restart_movement():
	move = true
	pass
