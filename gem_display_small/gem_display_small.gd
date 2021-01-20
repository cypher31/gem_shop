extends StaticBody2D

var case_type = "unpolished" #gem type to turn partical effect on or off

# Called when the node enters the scene tree for the first time.
func _ready():
	var set_bucket_gem = $popup_purchase/mc/pc/vbox/button_set_gem
	var popup = $popup_purchase
	var case = self
	
	popup.connect("update_bucket_texture", self, "_set_case_texture")
	case.connect("button_down", self, "_popup_purchase", [bucket_1])
	pass # Replace with function body.

func _popup_purchase(bucket):
	var popup = $popup_purchase
		
	popup.curr_bucket = bucket
	
	popup.popup_centered()
	return

func _set_case_texture(case, gem_type):
	var popup_purchase = $popup_purchase
	var bucket_name : String = case.get_name()
	var curr_array_pos = popup_purchase.curr_type_array_pos
	var curr_gem = popup_purchase.gem_types[curr_array_pos]
	
	var texture_gem_type = case.get_node("texture_bucket")
	var texture_path = "res://assets/actor_passive/gem_small/gem_"
	var texture = load(texture_path + gem_type + ".png")
		
	texture_gem_type.set_texture(texture)
	
	#make sure to show the texture now :)
	case.get_node("texture_bucket").show()
	case.gem_type = curr_gem
	case.gem_polished = false
	case.gem_quality = "rough"
	return
