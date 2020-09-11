extends Area2D

var direction_to = Vector2()

#Initial Speed of Vehicle
var speed = 100#100-200

var release : bool = false  #if true , car crossed or crossing the junction

var move : bool = true

var DIRECTIONS = {"Left" : Vector2.RIGHT,"Right"  : Vector2.LEFT,
					"Up" : Vector2.DOWN,"Down"  : Vector2.UP
}

# Initial vehicle position
func _ready():
	if direction_to:
		$VisibilityNotifier2D.position = DIRECTIONS[direction_to] * -14

# Update position of vehicle at each frame	
func _process(delta):
	speed = get_parent().set_speed
	if direction_to:
		if move:
			position += DIRECTIONS[direction_to] * speed * delta
# When vehicle is out of screen area
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

# Start/Stop the vehicle
func stop_movement():
	move = false

func restart_movement():
	move = true

func _on_Car_area_entered(area):
	if(area.name == "ROAD"):
		release = true
		move = true
	
	if (area.name.begins_with("Car") or area.name.begins_with("@Car")):
		get_parent().game_quit()
	
func _on_Car_Main_area_entered(area):
	if(area.name == "ROAD"):
		release = true
		move = true
	
	if (area.name.begins_with("Car") or area.name.begins_with("@Car")):
		get_parent().game_quit()
