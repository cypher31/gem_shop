extends Node

#global utility script
#this script holds common functions that can be called by the game at any time

#game specific signals


#general signals

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

var playerVariableDict = {

	}

# stored variables
var __gameState = {
};

#asset dictionary


var assetDict = {

	}

#stage scene dictionary


var stageSceneDict = {

}


#object scene dictionary

var objectSceneDict = {

	}

#music dictionary


var musicDict = {

	}

#sound sfx dictionary


var sfxDict = {

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
	
#	if scene == "stageHighScore":
#		print(final_score)
#		instanceScene.final_score = final_score
#		instanceScene.loadHighscores(final_score)
#		pass
#	instanceScene.set_position(Vector2(-960, -540))
	pass
	

func spawnObject(object, parent, position):
	var objectToInstance = object.instance()
	
	parent.add_child(objectToInstance)
	
	if objectToInstance.has_node("spawn"):
		var spawnPosition = objectToInstance.get_node("spawn").get_global_position();
		
		#move object to be spawned by the delta of given position and spawn node
		objectToInstance.set_global_position(position - spawnPosition)
	elif position != null:
		objectToInstance.set_global_position(position)
	else:
		pass
	pass
	

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
	pass