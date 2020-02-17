extends Popup


# Called when the node enters the scene tree for the first time.
func _ready():
	utility.connect("stage_pop_up", self, "_stage_pop_up")
	
	utility.sceneSwitch("stage_level_select", true, get_child(0))
	pass # Replace with function body.
	
	
func _stage_pop_up():
	self.popup()
	return
