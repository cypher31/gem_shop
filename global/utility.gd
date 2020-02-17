extends Node

#global utility script
#this script holds common functions that can be called by the game at any time

#game specific signals
signal user_dig
signal stage_pop_up
signal level_accepted

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
var stage_level_select = load("res://level_select/level_select.tscn")

var stageSceneDict = {
"stage_level_select" : stage_level_select
}

#dialog option scene dictionary
var level_cost_popup = load("res://level_cost_popup/level_cost_popup.tscn")

var dialogSceneDict = {
	"level_cost_popup" : level_cost_popup
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
var gem_sizes : Dictionary = {"small" : 0, "med" : 0, "large" : 0}

var jade_quality : Dictionary = {"super" : {"small" : 0, "med" : 0, "large" : 0}, "AAA" : {"small" : 0, "med" : 0, "large" : 0}, "AA" : {"small" : 0, "med" : 0, "large" : 0}, "A" : {"small" : 0, "med" : 0, "large" : 0}, "rough" : {"small" : 0, "med" : 0, "large" : 0}} 
var ruby_quality : Dictionary = {"super" : {"small" : 0, "med" : 0, "large" : 0}, "AAA" : {"small" : 0, "med" : 0, "large" : 0}, "AA" : {"small" : 0, "med" : 0, "large" : 0}, "A" : {"small" : 0, "med" : 0, "large" : 0}, "rough" : {"small" : 0, "med" : 0, "large" : 0}}
var emerald_quality : Dictionary = {"super" : {"small" : 0, "med" : 0, "large" : 0}, "AAA" : {"small" : 0, "med" : 0, "large" : 0}, "AA" : {"small" : 0, "med" : 0, "large" : 0}, "A" : {"small" : 0, "med" : 0, "large" : 0}, "rough" : {"small" : 0, "med" : 0, "large" : 0}}
var diamond_quality : Dictionary = {"super" : {"small" : 0, "med" : 0, "large" : 0}, "AAA" : {"small" : 0, "med" : 0, "large" : 0}, "AA" : {"small" : 0, "med" : 0, "large" : 0}, "A" : {"small" : 0, "med" : 0, "large" : 0}, "rough" : {"small" : 0, "med" : 0, "large" : 0}}

var gem_count_dict = {
	"jade" : jade_quality,
	"ruby" : ruby_quality,
	"emerald" : emerald_quality,
	"diamond" : diamond_quality,
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
	
	
func sceneSwitch(scene, bool_popup, current_scene): #add a "self" variable so the current scene can free itself before spawning the new screen
	var instanceScene = stageSceneDict[scene].instance()
	
	if bool_popup:
		get_node("/root/main/stage_container/stage_pop_up").add_child(instanceScene)
		emit_signal("stage_pop_up")
	else:
		get_node("/root/main/stage_container").add_child(instanceScene)
	
	current_scene.queue_free()
	
#	if scene == "stageHighScore":
#		print(final_score)
#		instanceScene.final_score = final_score
#		instanceScene.loadHighscores(final_score)
#		pass
#	instanceScene.set_position(Vector2(-960, -540))
	pass


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
	if gem_size == "small":
		gem_actor.queue_free()
		
		var asset_path = "res://assets/actor_passive/gem_small/gem_"
		var asset = load(asset_path + gem_type + ".png")
		
		var grid = gem_small_container.get_node("PanelContainer/gem_grid")
		
		var gem = TextureRect.new()
		gem.set_texture(asset)
		
		grid.add_child(gem)
		
		gem_count_dict[gem_type][gem_quality][gem_size] += 1
		pass
	
	print(gem_count_dict)
	pass