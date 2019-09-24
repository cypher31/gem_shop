extends Node

#basic state class to hold and manipulate various states of the game and objects within the game

#creature state

var creature_stats : Dictionary = {
	"HUN" : "",
	"HAP" : "",
	"HYG" : "",
	"DIS" : ""
}

var creature_state : Dictionary = {
	"DOB" : "",
	"NAM" : "",
	"TYP" : "",
	"STA" : creature_stats
	}


func update_creature(key, bool_stat, update_to_this):
	#check if trying to update creature stat
	if bool_stat:
		creature_stats[key] = update_to_this
	else:
		creature_state[key] = update_to_this
	
	return creature_state

