extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	$cc/button_select.connect("button_up", self, "_level_pin_selected")
	pass # Replace with function body.


func _level_pin_selected():
	utility.dialog_popup("level_cost_popup", true)
	return