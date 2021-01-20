extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	utility.connect("clear_current_scene", self, "_clear_current_scene")
	utility.connect("NPC_coin_spawn", self, "_NPC_coin_spawn")
	pass # Replace with function body.


func _clear_current_scene():
	var children : Array = get_children()
	
	for child in children:
		if child.get_name() != "stage_store_front" || child.get_name() != "parent_coin":
			child.queue_free() #stage_container should only have one child
		else: #hide the store so accidental button clicks don't happen
			print(child.visible)
			if child.visible:
				child.hide()
			else:
				child.show()
	return
	
func _NPC_coin_spawn(coin_position):
	var coin = utility.spawn_object(utility.active_actor_dict["coin"], $parent_coin, coin_position)
	return
