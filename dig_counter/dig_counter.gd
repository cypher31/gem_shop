extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	utility.connect("user_dig", self, "__update_dig_counter")
	pass # Replace with function body.

func __update_dig_counter():
	var bar = $hbox/progress_bar
	var current_value = $hbox/progress_bar.get_value()
	var new_value = current_value - 1
	
	bar.set_value(new_value)
	pass
