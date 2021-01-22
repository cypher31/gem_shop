extends StaticBody2D

var case_type = "unpolished" #gem type to turn partical effect on or off
var gem_type : String
var gem_polished : bool
var gem_quality : String

# Called when the node enters the scene tree for the first time.
func _ready():
	var popup_set_gem = get_parent().get_parent().get_node("popup_purchase")
	var case_button = $case_button
	
	popup_set_gem.connect("update_case_texture", self, "_set_case_texture")
	case_button.connect("button_down", self, "_popup_purchase", [self])
	pass # Replace with function body.

func _popup_purchase(case):
	var popup = get_parent().get_parent().get_node("popup_purchase")
		
	popup.curr_case = case
	popup.curr_type = "case"
	
	popup.popup_centered()
	return

func _set_case_texture(case, gem_type):
	var popup_purchase = get_parent().get_parent().get_node("popup_purchase")
	var case_name : String = case.get_name()
	var curr_array_pos = popup_purchase.curr_type_array_pos
	var curr_gem = popup_purchase.gem_types[curr_array_pos]

	var texture_gem_type = case.get_node("sprite_gem")
	var texture_path = "res://assets/actor_passive/gem_small/gem_"
	var texture = load(texture_path + gem_type + ".png")
		
	texture_gem_type.set_texture(texture)
	print("WORKING")

	case.gem_type = curr_gem
	case.gem_polished = false
	case.gem_quality = "rough"
	return
