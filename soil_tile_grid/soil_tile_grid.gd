extends Node2D

#node for generating and holding excavation grid layouts
var tile_name : String = "soil_tile_node"

var grid_size : Vector2 = Vector2(10, 3) #needs to be variable input here
var tile_size : Vector2 = utility.tile_size
var grid_depth : int = 3
var z_draw_depth : int = 0
var soil_column : int = 0

var gem_type : String
var camp_type : String
#var gem_grade : String

var grid_spawn_array : Array

var tile_align_mod : float = 24 #align the tiles so that they are touching
var tile_depth_mod : float = 9 #pixel depth of 3-d look of tile

var tile_position_array : Array = [] #array to hold locations of tiles

# Called when the node enters the scene tree for the first time.
func _ready():
	if camp_type.to_lower() == "investigation":
		grid_size = Vector2(5,3)
	elif camp_type.to_lower() == "expedition":
		grid_size = Vector2(7,4)
	elif camp_type.to_lower() == "excursion":
		grid_size = Vector2(9,5)
	elif camp_type.to_lower() == "commercial":
		grid_size = Vector2(11,6)
	
	_center_grid()
	spawn_tile_grid(grid_size_calc(grid_size), grid_depth)
	spawn_coins(tile_position_array, grid_depth)
	spawn_gems(tile_position_array, grid_depth)
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
	var tile = utility.spawn_object(utility.active_actor_dict[tile_name], self, position)
	
	for i in range(0, depth):
		var position : Vector2
		for j in range(0, grid.size()):
			for k in range(0, grid[j]):
				if j & 1:
					position = Vector2(tile_size.x + k * utility.tile_size.x,j * (utility.tile_size.y - tile_align_mod) - z_draw_depth * tile_depth_mod)
				else:
					position = Vector2(tile_size.x + (k - 0.5) * utility.tile_size.x, j * (utility.tile_size.y - tile_align_mod) - z_draw_depth * tile_depth_mod)
					
				var tile_instance = utility.spawn_object(utility.active_actor_dict[tile_name], self, position)
				tile_position_array.append(tile_instance.get_global_position())
				tile_instance.set_z_index(z_draw_depth)
				tile_instance.soil_column = soil_column

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
	
	
func spawn_gems(tile_positions, depth):
	var total_gems : int
	var gem_type_instance = gem_type 
	
	var chance_rough : float
	var chance_a : float
	var chance_aa : float
	var chance_aaa : float
	
	total_gems = sqrt(tile_positions.size()) * 2
	print(camp_type)
	if camp_type == "investigation":
		chance_rough = 0.80
		chance_a = 0.10
		chance_aa = 0.06
		chance_aaa = 0.04
	elif camp_type == "expedition":
		chance_rough = 0.60
		chance_a = 0.25
		chance_aa = 0.10
		chance_aaa = 0.05
	elif camp_type == "excursion":
		chance_rough = 0.40
		chance_a = 0.30
		chance_aa = 0.20
		chance_aaa = 0.10
	elif camp_type == "commercial":
		chance_rough = 0.20
		chance_a = 0.40
		chance_aa = 0.25
		chance_aaa = 0.15
	
	var acc_weight_rough : float = chance_rough
	var acc_weight_a : float = chance_rough + chance_a
	var acc_weight_aa : float = chance_rough + chance_a + chance_aa
	var acc_weight_aaa : float = chance_rough + chance_a + chance_aa + chance_aaa
	var total_roll_weight : float = chance_rough + chance_a + chance_aa + chance_aaa
	
	for i in range(0, total_gems):
		var random_num = randi() % tile_positions.size()
		var random_depth = (randi() % depth) - 1
		
		var random_num_grade = rand_range(0,1)
		var gem_grade : String
		
		if random_num_grade < acc_weight_rough:
			gem_grade = "rough"
		elif random_num_grade < acc_weight_a and random_num_grade > acc_weight_rough:
			gem_grade = "a"
		elif random_num_grade < acc_weight_aa and random_num_grade > acc_weight_a:
			gem_grade = "aa"
		elif random_num_grade < acc_weight_aaa and random_num_grade > acc_weight_aa:
			gem_grade = "aaa"

		var gem = utility.spawn_object(utility.active_actor_dict["gem_small"], $gem_spawn,tile_positions[random_num])
		utility.emit_signal("update_gem", gem_type_instance, gem_grade, camp_type)
		gem.gem_type = gem_type_instance
		gem.set_z_index(random_depth)
		pass
	pass


func _center_grid():
	var tile_size_x = tile_size.x
	var total_x_size = tile_size.x * grid_size.x
	
	set_position(Vector2(get_position().x - total_x_size/2, get_position().y))
	
	return
