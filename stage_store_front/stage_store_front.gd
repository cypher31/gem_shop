extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var button_field_camp = $store_front_GUI/button_field_camp
	var start_field_camp = $camp_select/mc/pc/vbox/button_start_field_camp
	var button_view_collection = $store_front_GUI/button_view_collection
	var button_store_upgrade = $store_front_GUI/button_store
	
	button_field_camp.connect("button_up", self, "_camp_select_pop")
	button_view_collection.connect("button_up", self, "_view_collection_pop")
	button_store_upgrade.connect("button_up", self, "_store_upgrade_pop")
	
	utility.connect("NPC_coin_spawn", self, "_NPC_coin_spawn")
	pass # Replace with function body.


func _camp_select_pop():
	var camp_select_pop = $camp_select
	
	camp_select_pop.popup_centered()
	return
	
func _view_collection_pop():
	var view_selection_pop = $popup_collection
	
	view_selection_pop.popup_centered()
	return
	
func _store_upgrade_pop():
	var store_upgrade_pop = $popup_store_upgrade
	
	return

func _NPC_coin_spawn(coin_position):
	var coin = utility.spawn_object(utility.active_actor_dict["coin"], $parent_coin, coin_position)
	return
