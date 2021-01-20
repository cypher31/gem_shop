extends PopupPanel

#script that handles gem selection for purchase counter
var gem_types : Array = ["garnet", "emerald", "jade", "ruby"]

var curr_type_array_pos : int = 0 #keep track of the current position in the gem type array

# Called when the node enters the scene tree for the first time.
func _ready():
	var button_type_right = $mc/pc/vbox/hbox_gem_type/button_type_right
	var button_type_left = $mc/pc/vbox/hbox_gem_type/button_type_left
	
	button_type_right.connect("button_down", self, "_type_update", [1])
	button_type_left.connect("button_down", self, "_type_update", [-1])
	
	#set initial gem_type for the top most gem
	var label_title = $mc/pc/vbox/hbox/mc/label_title
	var texture_gem_type = $mc/pc/vbox/hbox_gem_type/texture_gem_type
	var label_type_string : String = gem_types[0].capitalize()
	var texture_path = "res://assets/actor_passive/gem_small/gem_"
	var texture = load(texture_path + gem_types[0] + ".png")
	
	label_title.set_text(label_type_string)
	texture_gem_type.set_texture(texture)
	
	#set intial gems for gems in the grid
	var gem_grid = $mc/pc/vbox/GridContainer
	var grid_children = gem_grid.get_children()
	
	for child in grid_children:
		var grade = child.get_name()
		var type = gem_types[0]
		var texture_node_gem = child.get_node("texture_gem")
		var label_polished = child.get_node("gem_count_P")
		var label_unpolished = child.get_node("gem_count_UP")
		var label_polished_string : String = " P: " + String(utility.gem_count_dict[type][grade].p)
		var label_unpolished_string : String = "UP: " + String(utility.gem_count_dict[type][grade].up)
		texture_path = "res://assets/actor_passive/gem_small/gem_"
		texture = load(texture_path + gem_types[0] + ".png")
		
		texture_node_gem.set_texture(texture)
		label_unpolished.set_text(label_unpolished_string)
		label_polished.set_text(label_polished_string)
	pass # Replace with function body.


func _type_update(dir):
	var next_array_pos = curr_type_array_pos + dir
	
	#update title gem
	if next_array_pos > gem_types.size() - 1:
		next_array_pos = 0
	elif next_array_pos < 0:
		next_array_pos = gem_types.size() - 1
		pass
	
	var label_title = $mc/pc/vbox/hbox/mc/label_title
	var texture_gem_type = $mc/pc/vbox/hbox_gem_type/texture_gem_type
	var label_string : String = gem_types[next_array_pos].capitalize()
	var texture_path = "res://assets/actor_passive/gem_small/gem_"
	var texture = load(texture_path + gem_types[next_array_pos] + ".png")
	
	label_title.set_text(label_string)
	texture_gem_type.set_texture(texture)
	
	#update gems in the grid
	var gem_grid = $mc/pc/vbox/GridContainer
	var grid_children = gem_grid.get_children()

	for child in grid_children:
		var grade = child.get_name()
		var type = gem_types[next_array_pos]
		var texture_node_gem = child.get_node("texture_gem")
		var label_polished = child.get_node("gem_count_P")
		var label_unpolished = child.get_node("gem_count_UP")
		var label_polished_string : String = " P: " + String(utility.gem_count_dict[type][grade].p)
		var label_unpolished_string : String = "UP: " + String(utility.gem_count_dict[type][grade].up)
		texture_path = "res://assets/actor_passive/gem_small/gem_"
		texture = load(texture_path + gem_types[next_array_pos] + ".png")
		
		texture_node_gem.set_texture(texture)
		label_unpolished.set_text(label_unpolished_string)
		label_polished.set_text(label_polished_string)
	
	curr_type_array_pos = next_array_pos #update array position
	return
