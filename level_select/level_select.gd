extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$actors/gui/mc/background/active/gui_cont/button_close_stage.connect("button_up", self, "_button_close_stage")
	pass # Replace with function body.


func _button_close_stage():
	self.queue_free()
	pass