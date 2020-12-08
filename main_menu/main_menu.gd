extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var field_camp = $vbox/button_debug_field_camp
	var stage_select = $vbox/button_debug_stage_select
	
	field_camp.connect("button_up", utility, "sceneSwitch", ["stage_field_camp"])
	stage_select.connect("button_up", utility, "sceneSwitch", ["stage_level_select"])
	
	pass # Replace with function body.
