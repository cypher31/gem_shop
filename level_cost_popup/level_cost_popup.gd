extends Popup

var level_cost : int = 5000

# Called when the node enters the scene tree for the first time.
func _ready():
	$cc/Panel/vbox/hbox/button_accept.connect("button_up", self, "_level_selected")
	$cc/Panel/vbox/hbox/button_deny.connect("button_up", self, "_level_denied")
	pass # Replace with function body.


func _level_selected():
	utility.emit_signal("level_selected", [level_cost]) #will have to check if user has enough money to accept the level
	print("LEVEL SELECTED")
	return
	
func _level_denied():
	self.queue_free()
	return
