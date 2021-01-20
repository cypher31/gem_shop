extends PopupPanel

#script that handles field camp selection based on the current gem
var gem_types : Array = ["garnet", "emerald", "jade", "ruby"]
var camp_types : Array = ["investigation", "expedition", "excursion", "commercial"]

var camp_costs : Dictionary = {
	"investigation" : 200,
	"expedition" : 600,
	"excursion" : 1200,
	"commercial" : 2400
}

var curr_type_array_pos : int = 0 #keep track of the current position in the gem type array
var curr_camp_array_pos : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var button_type_right = $mc/pc/vbox/hbox_gem_type/button_type_right
	var button_type_left = $mc/pc/vbox/hbox_gem_type/button_type_left
	var button_grade_right = $mc/pc/vbox/hbox_gem_grade/button_grade_right
	var button_grade_left = $mc/pc/vbox/hbox_gem_grade/button_grade_left
	var button_start = $mc/pc/vbox/button_start_field_camp
	
	button_type_right.connect("button_down", self, "_type_update", [1])
	button_type_left.connect("button_down", self, "_type_update", [-1])
	
	button_grade_right.connect("button_down", self, "_camp_update", [1])
	button_grade_left.connect("button_down", self, "_camp_update", [-1])
	
	button_start.connect("button_down", self, "_field_camp_param_setter")
	
	#set initial gem_type
	var label_gem_type = $mc/pc/vbox/label_gem_type
	var texture_gem_type = $mc/pc/vbox/hbox_gem_type/texture_gem_type
	var label_gem_grade = $mc/pc/vbox/hbox_gem_grade/label_gem_grade
	var label_type_string : String = gem_types[0].capitalize()
	var label_camp_string : String = camp_types[0].to_upper()
	var texture_path = "res://assets/actor_passive/gem_small/gem_"
	var texture = load(texture_path + gem_types[0] + ".png")
	
	label_gem_type.set_text(label_type_string)
	texture_gem_type.set_texture(texture)
	label_gem_grade.set_text(label_camp_string)
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
	
func _camp_update(dir):
	var next_array_pos = curr_camp_array_pos + dir
	
	if next_array_pos > camp_types.size() - 1:
		next_array_pos = 0
	elif next_array_pos < 0:
		next_array_pos = camp_types.size() - 1
		pass
	
	var label_gem_grade = $mc/pc/vbox/hbox_gem_grade/label_gem_grade
	var label_camp_string : String = camp_types[next_array_pos].to_upper()
	
	label_gem_grade.set_text(label_camp_string)
	
	curr_camp_array_pos = next_array_pos #update array position
	return
	
func _field_camp_param_setter():
	var curr_coin_count = utility.coin_count
	var gem_type = gem_types[curr_type_array_pos]
	var camp_type = camp_types[curr_camp_array_pos]
	var camp_value = camp_costs[camp_type]
	var params : Dictionary = {}
	var popup = self
	
	if curr_coin_count >= camp_costs[camp_type]:
		utility.get_coin(null, -camp_value)
		params["gem_type"] = gem_type
		params["camp_type"] = camp_type
		
		popup.hide()
		utility.load_field_camp(params)
	else:
		print("NEED MORE MONEY")
	return
