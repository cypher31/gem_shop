extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	utility.connect("clear_current_scene", self, "_clear_current_scene")
	pass # Replace with function body.


func _clear_current_scene():
	var children : Array = get_children()
	
	for child in children:
		if child.get_name() != "stage_store_front":
			child.queue_free() #stage_container should only have one child
	return
