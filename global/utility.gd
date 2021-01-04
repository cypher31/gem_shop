extends Node

#global utility script
#this script holds common functions that can be called by the game at any time

#game specific signals
signal user_dig
signal stage_pop_up
signal level_accepted
signal clear_current_scene
signal update_gem #update spawned gems to have the correct type
signal bucket_set #when a gem bucket is set this signal is emitted

#general signals

#global object variables
var coin_count_label : Control
var gem_small_container : Control
var gem_med_container : Control
var gem_large_container : Control

#devic info variables
var deviceType
var deviceWindowSize
var inputDevice = "keyboard"
const FILE_NAME = "user://gamestate.save";


#layout holder
#var layoutHolder = []

#start base resolution
var resolution = Vector2(1280, 720)
#end base resolution

#start set margin
#var sideMargin = 128 #pixels
#var topMargin = 128 #pixels
#var columnMargin = 64 #pixels
#end set margin


#player variables (for saving and for the player script to grab)
var coin_count : int

var user_variables = {
	"coin_count" : coin_count
	}

# stored variables
var __gameState = {
};

#asset dictionary


var assetDict = {

	}

#stage scene dictionary
var stage_store_front = load("res://stage_store_front/stage_store_front.tscn")
var stage_level_select = load("res://level_select/level_select.tscn")
var stage_field_camp = load("res://field_camp/field_camp.tscn")

var stageSceneDict = {
"stage_store_front" : stage_store_front,
"stage_level_select" : stage_level_select,
"stage_field_camp" : stage_field_camp
}

#dialog option scene dictionary
var level_cost_popup = load("res://level_cost_popup/level_cost_popup.tscn")

var dialogSceneDict = {
	"level_cost_popup" : level_cost_popup
	}

#background dictionary
var map_background_1 = load("res://assets/prototype/background_1.png")
var map_background_2 = load("res://assets/prototype/background_2.png")
var map_background_3 = load("res://assets/prototype/background_3.png")

var backgroundDict = {
	"map_background_1" : map_background_1,
	"map_background_2" : map_background_2,
	"map_background_3" : map_background_3
	}

#active actor scene dictionary
var soil_tile_node = preload("res://soil_tile/soil_tile.tscn")
var tile_size : Vector2 = soil_tile_node.instance().get_node("Sprite").get_texture().get_size() # get the size of tiles currently being used

var coin = preload("res://coin/coin.tscn")
var gem_small = preload("res://gem_small/gem_small.tscn")

var active_actor_dict = {
	"soil_tile_node" : soil_tile_node,
	"coin" : coin,
	"gem_small" : gem_small
	}

#passive actor scene dictonary

var passive_actor_dict = {
	
	}
#music dictionary


var musicDict = {

	}

#sound sfx dictionary


var sfxDict = {

	}


#dictionary to hold all of the users gems
var jade_quality : Dictionary = {"aaa" : {"p" : 100, "up" : 0}, "aa" : {"p" : 100, "up" : 0}, "a" : {"p" : 100, "up" : 0}, "rough" : {"p" : 100, "up" : 0}} 
var ruby_quality : Dictionary = {"aaa" : {"p" : 0, "up" : 100}, "aa" : {"p" : 0, "up" : 100}, "a" : {"p" : 0, "up" : 100}, "rough" : {"p" : 0, "up" : 100}} 
var emerald_quality : Dictionary = {"aaa" : {"p" : 100, "up" : 0}, "aa" : {"p" : 100, "up" : 0}, "a" : {"p" : 100, "up" : 0}, "rough" : {"p" : 100, "up" : 0}} 
var garnet_quality : Dictionary = {"aaa" : {"p" : 0, "up" : 100}, "aa" : {"p" : 0, "up" : 100}, "a" : {"p" : 0, "up" : 100}, "rough" : {"p" : 0, "up" : 100}} 

var gem_count_dict = {
	"jade" : jade_quality,
	"ruby" : ruby_quality,
	"emerald" : emerald_quality,
	"garnet" : garnet_quality,
	}
	
	
var unlock_dict = {
	"gem_storage_small" : true,
	"gem_storage_med" : false,
	"gem_storage_large" : false,
	"gem_bucket_1" : true,
	"gem_bucket_2" : false,
	"gem_bucket_3" : false,
}
	
func _ready():
	randomize()
	
	#global signals


	#get device info
	deviceWindowSize = OS.get_window_size()
	var screen_size = OS.get_screen_size(0)
	
	#center window to screen
	OS.set_window_position(screen_size * .5 - deviceWindowSize * .5)
	pass


#func readTextFile(f, d): #file, destination
#	#function for reading through a text file and generating enemies
#	var file = File.new()
#
#	if f != null:
#		file.open(f, file.READ)
#		pass
#
#	var text = file.get_as_text()
#	var jsonToText = JSON.parse(text)
#
#	d.emit_signal("newText", jsonToText.result, "layout")
#	pass
	
	
func sceneSwitch(scene): #add a "self" variable so the current scene can free itself before spawning the new screen
	var instanceScene = stageSceneDict[scene].instance()
	
	get_node("/root/main/stage_container").add_child(instanceScene)
	
	#remove current screen variable and replace with signal
	emit_signal("clear_current_scene")
	pass


func load_field_camp(params):
	var camp_instance = stageSceneDict["stage_field_camp"].instance()
	var gem_type = params["gem_type"]
	var camp_type = params["camp_type"]
	
	var camp_loader = camp_instance.get_node("actors/active/soil_tile_grid")
	camp_loader.gem_type = gem_type
	camp_loader.camp_type = camp_type
		
	get_node("/root/main/stage_container").add_child(camp_instance)

	#remove current screen variable and replace with signal
	emit_signal("clear_current_scene")
	
	return


func dialog_popup(scene, bool_exclusive):
	var instance_dialog = dialogSceneDict[scene].instance()
	
	instance_dialog.set_exclusive(bool_exclusive)
	
	get_node("/root/main/stage_container/dialog_container").add_child(instance_dialog)
	instance_dialog.popup()
	return

func spawn_object(object, parent, position):
	var objectToInstance = object.instance()
	
	parent.add_child(objectToInstance)
	
	if parent.has_node("spawn"):
		var spawnPosition = parent.get_node("spawn").get_global_position();
		
		#move object to be spawned by the delta of given position and spawn node
		objectToInstance.set_global_position(position + spawnPosition)
	elif position != null:
		objectToInstance.set_global_position(position)
	else:
		pass
	return objectToInstance
	

func getGameState():
	return __gameState;

#func generate2DCollider(verticies, collisionNode):
#	var object = collisionNode.get_parent()
#	var poolArray = []
#	var vertexDirection = Vector2()
#
#	for vertex in verticies:
#		vertexDirection = vertex.normalized()
#		poolArray.append(vertex + vertexDirection)
#		pass
#
#	poolArray = PoolVector2Array(poolArray)
#
#	collisionNode.set_polygon(poolArray)
#	return;

	
func change_music(audio):
	var stream_music = get_tree().get_current_scene().get_node("sound_player_music")
	
	stream_music.set_stream(musicDict[audio])
	stream_music.play()
	pass
	
func play_sound_effect(sfx, bus, free):
	var stream_sfx = bus
	bus.connect("finished", self, "sfx_finished", [bus, free])
	
	stream_sfx.set_stream(sfxDict[sfx]) #sfx should be called from sfx dictionary
	stream_sfx.play()
	
	pass
	
func sfx_finished(bus,free):
	if free:
		bus.queue_free()
	pass
	
	
func tile_damage(tile_health):
	tile_health = tile_health - 1
	return tile_health
	
	
func tile_destroy(tile):
	tile.queue_free()
	
	var timer = Timer.new()
	timer.connect("timeout", self, "__coin_timer_timeout")
	add_child(timer)
	timer.set_wait_time(.2)
	timer.set_one_shot(true)
	timer.start()
	pass
	
	
func __coin_timer_timeout():
	emit_signal("user_dig")
	pass


func get_coin(coin):
	var coin_value = 100
	
	coin_count += coin_value
	
	coin.queue_free()
	
	coin_count_label.set_text(str(coin_count))
	pass
	

func get_gem(gem_actor, gem_size, gem_type, gem_quality):
	gem_actor.queue_free()
	
	var asset_path = "res://assets/actor_passive/gem_small/gem_"
	var asset = load(asset_path + gem_type + ".png")
	
	var grid = gem_small_container.get_node("gem_grid")
	
	var gem = TextureRect.new()
	gem.set_texture(asset)
	
	grid.add_child(gem)
	
	gem_count_dict[gem_type][gem_quality]["up"] += 1
	pass
