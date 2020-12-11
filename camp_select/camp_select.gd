extends PopupPanel

#script that handles field camp selection based on the current gem
var gem_types : Array = ["amber", "emerald", "jade", "ruby"]
var grade_types : Array = ["Rough", "A", "AA", "AAA"]

var curr_type_array_pos : int = 0 #keep track of the current position in the gem type array

# Called when the node enters the scene tree for the first time.
func _ready():
	var button_type_right = $mc/pc/vbox/hbox_gem_type/button_type_right
	var button_type_left = $mc/pc/vbox/hbox_gem_type/button_type_left
	var button_grade_right = $mc/pc/vbox/hbox_gem_grade/button_grade_right
	var button_grade_left = $mc/pc/vbox/hbox_gem_grade/button_grade_left
	var button_start = $mc/pc/vbox/button_start_field_camp
	
	button_type_right.connect("button_down", self, "_type_update", [1])
	button_type_left.connect("button_down", self, "_type_update", [-1])
	
	button_grade_right.connect("button_down", self, "_grade_update", [1])
	button_grade_left.connect("button_down", self, "_grade_update", [-1])
	
	#set initial gem_type
	var label_gem_type = $mc/pc/vbox/label_gem_type
	var texture_gem_type = $mc/pc/vbox/hbox_gem_type/texture_gem_type
	var label_string : String = gem_types[0].capitalize()
	var texture_path = "res://assets/actor_passive/gem_small/gem_"
	var texture = load(texture_path + gem_types[0] + ".png")
	
	label_gem_type.set_text(label_string)
	texture_gem_type.set_texture(texture)
	pass # Replace with function body.


func _type_update(dir):
	var next_array_pos = curr_type_array_pos + dir
	
	if next_array_pos > gem_types.size() - 1:
		next_array_pos = 0
	elif next_array_pos < 0:
		next_array_pos = gem_types.size() - 1
		pass
	
	var label_gem_type = $mc/pc/vbox/label_gem_type
	var texture_gem_type = $mc/pc/vbox/hbox_gem_type/texture_gem_type
	var label_string : String = gem_types[next_array_pos].capitalize()
	var texture_path = "res://assets/actor_passive/gem_small/gem_"
	var texture = load(texture_path + gem_types[next_array_pos] + ".png")
	
	label_gem_type.set_text(label_string)
	texture_gem_type.set_texture(texture)
	
	curr_type_array_pos = next_array_pos #update array position
	return
	
func _grade_update(dir):
	
	return
