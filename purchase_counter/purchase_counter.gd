extends Node2D

var gem_type_bucket_1 : String
var gem_type_bucket_2 : String
var gem_type_bucket_3 : String


# Called when the node enters the scene tree for the first time.
func _ready():
	var popup_gem_set = get_parent().get_node("popup_purchase")
	var bucket_1 = $gem_bucket_1
	var bucket_2 = $gem_bucket_2
	var bucket_3 = $gem_bucket_3
	var set_bucket_gem = popup_gem_set.get_node("mc/pc/vbox/button_set_gem")
	
	popup_gem_set.connect("update_bucket_texture", self, "_set_bucket_texture")
	
	if utility.unlock_dict_store["gem_bucket_1"] == true:
		bucket_1.show()
#		bucket_1.set_disabled(false)
		bucket_1.connect("button_down", self, "_popup_purchase", [bucket_1])
		
	if utility.unlock_dict_store["gem_bucket_2"] == true:
		bucket_2.show()
		bucket_2.set_disabled(false)
		bucket_2.connect("button_down", self, "_popup_purchase", [bucket_2])
		
	if utility.unlock_dict_store["gem_bucket_3"] == true:
		bucket_3.show()
		bucket_3.set_disabled(false)
		bucket_3.connect("button_down", self, "_popup_purchase", [bucket_3])
		
	pass
	
func _popup_purchase(bucket):
	var popup = get_parent().get_node("popup_purchase")
		
	popup.curr_bucket = bucket
	popup.curr_type = "bucket"
	
	popup.popup_centered()
	popup.raise()
	return
	
func _set_bucket_texture(bucket, gem_type):
	var popup_purchase = get_parent().get_node("popup_purchase")
	var bucket_name : String = bucket.get_name()
	var curr_array_pos = popup_purchase.curr_type_array_pos
	var curr_gem = popup_purchase.gem_types[curr_array_pos]
	
	var texture_gem_type = bucket.get_node("texture_bucket")
	var texture_path = "res://assets/actor_passive/gem_small/gem_"
	var texture = load(texture_path + gem_type + ".png")
		
	texture_gem_type.set_texture(texture)
	
	#make sure to show the texture now :)
	bucket.get_node("texture_bucket").show()
	bucket.gem_type = curr_gem
	bucket.gem_polished = false
	bucket.gem_quality = "rough"
	utility.purchase_dict[bucket_name] = [bucket, curr_gem]
	return
