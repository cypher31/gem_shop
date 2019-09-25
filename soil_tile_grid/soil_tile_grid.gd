extends Node2D

#node for generating and holding excavation grid layouts
var tile_name : String = "soil_tile_node"

var grid_size : Vector2 = Vector2(7, 5)
var tile_size : Vector2 = utility.tile_size
var grid_depth : int = 2
var z_draw_depth : int = 0

var grid_spawn_array : Array

var tile_align_mod : float = 40 #align the tiles so that they are touching

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_tile_grid(grid_size_calc(grid_size))
	pass # Replace with function body.


func grid_size_calc(grid_size):
	#set row sizes
	for i in range(1, grid_size.y + 1):
		if i & 1:
			grid_spawn_array.append(grid_size.x)
		else:
			grid_spawn_array.append(grid_size.x - 1)
		pass
		
	return grid_spawn_array
	
	
func spawn_tile_grid(array):
	for i in range(0, grid_depth):
		var position : Vector2
		for j in range(0, array.size()):
			for k in range(0, array[j]):
				if j & 1:
					position = Vector2(tile_size.x + k * utility.tile_size.x,j * (utility.tile_size.y - tile_align_mod))
				else:
					position = Vector2(tile_size.x + (k - 0.5) * utility.tile_size.x, j * (utility.tile_size.y - tile_align_mod))
					
				var tile = utility.spawn_object(utility.active_actor_dict[tile_name], self, position)
				tile.set_z_index(z_draw_depth)

				pass
			pass
		z_draw_depth -= 1
		pass
	pass