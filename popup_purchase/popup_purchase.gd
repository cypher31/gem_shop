extends PopupPanel

#script that handles gem selection for purchase counter
var gem_types : Array = ["garnet", "emerald", "jade", "ruby"]
var curr_type_array_pos : int = 0 #keep track of the current position in the gem type array
var curr_bucket #the current bucket selected

signal update_bucket_texture
# Called when the node enters the scene tree for the first time.
func _ready():
	var button_type_right = $mc/pc/vbox/hbox_gem_type/button_type_right
	var button_type_left = $mc/pc/vbox/hbox_gem_type/button_type_left
	var button_set = $mc/pc/vbox/button_set_gem
	
	button_type_right.connect("button_down", self, "_type_update", [1])
	button_type_left.connect("button_down", self, "_type_update", [-1])
	button_set.connect("button_down", self, "_set_bucket_texture")
	
	#set initial gem_type
	var label_gem_type = $mc/pc/vbox/label_gem_type
	var texture_gem_type = $mc/pc/vbox/hbox_gem_type/texture_gem_type
	var label_type_string : String = gem_types[0].capitalize()
	var texture_path = "res://assets/actor_passive/gem_small/gem_"
	var texture = load(texture_path + gem_types[0] + ".png")
	
	label_gem_type.set_text(label_type_string)
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

func _set_bucket_texture():
	emit_signal("update_bucket_texture", curr_bucket, gem_types[curr_type_array_pos])
	hide()
	return
