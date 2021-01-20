extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	utility.connect("end_field_camp", self, "_end_field_camp")
	pass # Replace with function body.


func _end_field_camp():
	utility.emit_signal("clear_current_scene")
	return
