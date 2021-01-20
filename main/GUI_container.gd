extends Control
#script to handle global GUI updates


# Called when the node enters the scene tree for the first time.
func _ready():
	var button_global_settings = $button_settings_global
	var button_pop_close = $button_settings_global/popup_global_settings/mc/pc/vbox/hbox/button_close
	var button_shop_return = $button_settings_global/popup_global_settings/mc/pc/vbox/button_return_shop
	var button_quit_game = $button_settings_global/popup_global_settings/mc/pc/vbox/button_quit
	
	button_global_settings.connect("button_up", self, "_popup_settings")
	button_pop_close.connect("button_up", self, "_close_popup")
	button_shop_return.connect("button_up", self, "_return_to_shop", ["stage_store_front"])
	button_quit_game.connect("button_up", utility, "quit_game")
	pass # Replace with function body.

func _popup_settings():
	var popup_settings = $button_settings_global/popup_global_settings
	
	popup_settings.popup_centered()
	return
	
func _close_popup():
	var popup_settings = $button_settings_global/popup_global_settings
	
	popup_settings.hide()
	return
	
func _return_to_shop(stage):
	var popup_settings = $button_settings_global/popup_global_settings
	
	popup_settings.hide()
	utility.sceneSwitch(stage)
	return
	
func _quit_game():
	utility.quit_game()
	return
