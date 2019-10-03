extends Node2D

# soil tile that the user interacts with when attempting to locate gems within the excavation limits

var soil_tile_health : int = 1 #number of touches needed to destroy the tile
var soil_tile_dim : Vector2
var soil_column : int

var can_excavate : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
#	$Sprite/Control.connect("gui_input", self, "_action_input")
#	$Sprite/Control2.connect("gui_input", self, "_action_input")
	
	$Area2D.connect("input_event", self, "_action_input")
	soil_tile_dim = $Sprite.get_texture().get_size()
	
	pass # Replace with function body.

func _action_input(viewport, event, id):
	var overlapping_areas = $Area2D.get_overlapping_areas()
	var z_depth = get_z_index()
	var z_depth_array : Array

	
	if event.is_pressed() and event.button_index == BUTTON_LEFT:
		for tile in overlapping_areas:
			if tile.is_in_group("soil"):
				if tile.get_parent().soil_column == soil_column:
					z_depth_array.append(tile.get_parent().get_z_index())
					pass
		
		if z_depth_array.size() > 0:
			if z_depth >= z_depth_array.max():
				can_excavate = true
			elif z_depth_array.size() > 0:
				can_excavate = false
		else:
			can_excavate = true
			pass
		
		if can_excavate:
			soil_tile_health = utility.tile_damage(soil_tile_health)

		if soil_tile_health == 0:
			utility.tile_destroy(self)
			
		z_depth_array.clear()
	pass