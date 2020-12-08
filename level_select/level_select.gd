extends Node2D

onready var map_1 = $actors/gui/mc/active/gui_cont/level_location_pins/TabContainer/A/map_current_A
onready var map_2 = $actors/gui/mc/active/gui_cont/level_location_pins/TabContainer/AA/map_current_AA
onready var map_3 = $actors/gui/mc/active/gui_cont/level_location_pins/TabContainer/AAA/map_current_AAA

var map_current : String

# Called when the node enters the scene tree for the first time.
func _ready():
	$actors/gui/mc/active/gui_cont/button_close_stage.connect("button_up", self, "_button_close_stage")
	$actors/gui/mc/active/gui_cont/button_swipe_left.connect("button_up", self, "_button_change_map", ["left"])
	$actors/gui/mc/active/gui_cont/button_swipe_right.connect("button_up", self, "_button_change_map", ["right"])
	
	var map_default : String = "map_background_1"
	map_current = map_default
	
	map_1.set_texture(utility.backgroundDict[map_default])
	map_2.set_texture(utility.backgroundDict[map_default])
	map_3.set_texture(utility.backgroundDict[map_default])
	pass # Replace with function body.


func _button_close_stage():
	self.queue_free()
	pass
	
	
func _button_change_map(dir):
	#figure out current map number
	var map_number = int(map_current.split("_")[2])
	
	var map_next : String = "map_background_"
	
	if dir == "left":
		if map_number != 1:
			map_next = map_next + str(map_number - 1)
			map_1.set_texture(utility.backgroundDict[map_next])
			map_2.set_texture(utility.backgroundDict[map_next])
			map_3.set_texture(utility.backgroundDict[map_next])
			map_current = map_next
	elif dir == "right":
		if map_number != utility.backgroundDict.size():
			map_next = map_next + str(map_number + 1)
			map_1.set_texture(utility.backgroundDict[map_next])
			map_2.set_texture(utility.backgroundDict[map_next])
			map_3.set_texture(utility.backgroundDict[map_next])
			map_current = map_next
		pass
	
	return