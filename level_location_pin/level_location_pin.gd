extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	$cc/button_select.connect("button_up", self, "_level_pin_selected")
	pass # Replace with function body.


func _level_pin_selected():
	print(get_name()) #pin will need to bring up the excavation stage and free the level_select stage
	return