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
		var child_name : String = child.get_name()
		if child.get_name() != "stage_store_front" and child.get_name() != "parent_coin":
			child.queue_free() #stage_container should only have one child
		elif child.get_name() == "stage_store_front" || child.get_name() == "parent_coin":

			if child.is_visible():
				child.hide()
				if child_name == "stage_store":
					child.get_node("stage_blocker").show()
			else:
				child.show()
				if child_name == "stage_store":
					child.get_node("stage_blocker").hide()
	return

