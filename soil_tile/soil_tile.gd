extends Node2D

# soil tile that the user interacts with when attempting to locate gems within the excavation limits

var soil_tile_health : int = 1 #number of touches needed to destroy the tile
var soil_tile_dim : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite/Control.connect("gui_input", self, "_action_input")
	$Sprite/Control2.connect("gui_input", self, "_action_input")

	soil_tile_dim = $Sprite.get_texture().get_size()
	
	pass # Replace with function body.

func _action_input(event):
	if event.is_pressed() and event.button_index == BUTTON_LEFT:
		soil_tile_health = utility.tile_damage(soil_tile_health)
		print(event)

		if soil_tile_health == 0:
			utility.tile_destroy(self)
	pass