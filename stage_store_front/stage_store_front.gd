extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var button_field_camp = $store_front_GUI/button_field_camp
	var start_field_camp = $camp_select/mc/pc/vbox/button_start_field_camp
	var button_view_collection = $store_front_GUI/button_view_collection
	
	button_field_camp.connect("button_up", self, "_camp_select_pop")
	button_view_collection.connect("button_up", self, "_view_collection_pop")
	pass # Replace with function body.


func _camp_select_pop():
	var camp_select_pop = $camp_select
	
	camp_select_pop.popup_centered()
	return
	
func _view_collection_pop():
	var view_selection_pop = $camp_select
	
	view_selection_pop.popup_centered()
	return
