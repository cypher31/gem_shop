extends Control
#script to handle global GUI updates


# Called when the node enters the scene tree for the first time.
func _ready():
	var button_global_settings = $button_settings_global
	var button_pop_close = $button_settings_global/popup_global_settings/mc/pc/vbox/hbox/button_close
	
	button_global_settings.connect("button_up", self, "_popup_settings")
	button_pop_close.connect("button_up", self, "_close_popup")
	pass # Replace with function body.


func _popup_settings():
	var popup_settings = $button_settings_global/popup_global_settings
	
	popup_settings.popup_centered()
	return
	
func _close_popup():
	var popup_settings = $button_settings_global/popup_global_settings
	
	popup_settings.hide()
	return
