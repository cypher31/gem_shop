extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	utility.connect("user_dig", self, "__update_dig_counter")
	pass # Replace with function body.

func __update_dig_counter():
	var bar = $hbox/cc/progress_bar
	var bar_count = $hbox/mc/dig_count_left
	
	var current_value = $hbox/cc/progress_bar.get_value()
	var new_value = current_value - 1
	
	bar.set_value(new_value)
	bar_count.set_text(str(bar.get_value()))
	pass
