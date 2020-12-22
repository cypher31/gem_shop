extends Node2D

var gem_type_bucket_1 : String
var gem_type_bucket_2 : String
var gem_type_bucket_3 : String


# Called when the node enters the scene tree for the first time.
func _ready():
	var bucket_1 = $gem_bucket_1
	var bucket_2 = $gem_bucket_2
	var bucket_3 = $gem_bucket_3
	
	if utility.unlock_dict["gem_bucket_1"] == true:
		bucket_1.show()
#		bucket_1.set_disabled(false)
		bucket_1.connect("button_down", self, "_popup_purchase")
		
	if utility.unlock_dict["gem_bucket_2"] == true:
		bucket_2.show()
		bucket_2.set_disabled(false)
		
	if utility.unlock_dict["gem_bucket_3"] == true:
		bucket_3.show()
		bucket_3.set_disabled(false)
		

func _popup_purchase():
	var popup = $popup_purchase

	popup.popup_centered()
	return
