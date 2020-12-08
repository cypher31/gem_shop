extends Node2D

var gem_size : String = "small"#small med or large
var gem_type : String = "jade" #jade, emerald, diamond, etc.
var gem_quality : String = "rough"

# Called when the node enters the scene tree for the first time.
func _ready():
	utility.connect("user_dig", self, "__check_overlap") #when the user destroys a tile a timer is set to emit this signal
	pass # Replace with function body.


func __check_overlap():
	var area = $Area2D
	var overlapping_areas = area.get_overlapping_areas()
	var z_depth = get_z_index()
	var z_depth_array : Array
	
	var is_top_level : bool = false
	
	for tile in overlapping_areas:
		if tile.is_in_group("soil"):
			z_depth_array.append(tile.get_parent().get_z_index())
		pass

	if z_depth_array.size() > 0:
		if z_depth >= z_depth_array.max():
			is_top_level = true
		elif z_depth_array.size() > 0:
			is_top_level = false
	else:
		is_top_level = true
		pass
	
	if is_top_level:
		utility.get_gem(self, gem_size, gem_type, gem_quality)
		
	z_depth_array.clear()
	
	pass
