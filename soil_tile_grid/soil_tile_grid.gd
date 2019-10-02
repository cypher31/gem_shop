extends Node2D

#node for generating and holding excavation grid layouts
var tile_name : String = "soil_tile_node"

var grid_size : Vector2 = Vector2(5, 3)
var tile_size : Vector2 = utility.tile_size
var grid_depth : int = 3
var z_draw_depth : int = 0
var soil_column : int = 0

var grid_spawn_array : Array

var tile_align_mod : float = 24 #align the tiles so that they are touching
var tile_depth_mod : float = 9 #pixel depth of 3-d look of tile

var tile_position_array : Array = [] #array to hold locations of tiles

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_tile_grid(grid_size_calc(grid_size), grid_depth)
	spawn_coins(tile_position_array, grid_depth)
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
	
	
func spawn_tile_grid(grid, depth): #grid = grid_spawn_array
	for i in range(0, depth):
		var position : Vector2
		for j in range(0, grid.size()):
			for k in range(0, grid[j]):
				if j & 1:
					position = Vector2(tile_size.x + k * utility.tile_size.x,j * (utility.tile_size.y - tile_align_mod) - z_draw_depth * tile_depth_mod)
				else:
					position = Vector2(tile_size.x + (k - 0.5) * utility.tile_size.x, j * (utility.tile_size.y - tile_align_mod) - z_draw_depth * tile_depth_mod)
					
				var tile = utility.spawn_object(utility.active_actor_dict[tile_name], self, position)
				tile_position_array.append(tile.get_global_position())
				tile.set_z_index(z_draw_depth)
				tile.soil_column = soil_column

				soil_column += 1
				pass
			pass
		z_draw_depth += 1
		soil_column = 0
		pass
	soil_column = 0
	pass
	
func spawn_coins(tile_positions, depth):
	var total_coins : int

	total_coins = sqrt(tile_positions.size())

	for i in range(0, total_coins):
		var random_num = randi() % tile_positions.size()
		var random_depth = (randi() % depth) - 1

		var coin = utility.spawn_object(utility.active_actor_dict["coin"], $coin_spawn,tile_positions[random_num])
		coin.set_z_index(random_depth)
		pass
	pass