extends Node

# PRIVATE FUNCTION. CALLED AT THE MIDDLE OF THE TRANSITION ANIMATION
func change_scene():
	return get_tree().change_scene("res://Main.tscn")

func _ready():
	get_node("AnimationPlayer").play("trans")#Fade animation started on node init
