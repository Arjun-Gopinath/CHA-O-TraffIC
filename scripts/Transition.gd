extends Node

# PUBLIC FUNCTION. CALLED WHENEVER YOU WANT TO CHANGE SCENE
#func fade_to(scn_path):
#	path = scn_path # store the scene path
#	var player = get_node("/root/transition").get_node("AnimationPlayer")
#	print(player)
#	get_node("AnimationPlayer").play("trans") # play the transition animation

## PRIVATE FUNCTION. CALLED AT THE MIDDLE OF THE TRANSITION ANIMATION
func change_scene():
	return get_tree().change_scene("res://Main.tscn")

func _ready():
	get_node("AnimationPlayer").play("trans")#Fade animation started on node init

