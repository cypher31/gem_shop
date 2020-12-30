extends Node2D

#node that handles generating NPC characters and purchasing of available gems

#base values for gem stones
#should only be modified by multipliers 
const worth_garnet : int = 50
const worth_jade : int = 100
const worth_emerald : int = 200
const worth_ruby : int = 500

var curr_npc_count : int = 0
var npc_spawn_rate : int = 0 #number of NPC to spawn per x time

var time_base_purchase : int = 20 #base number of seconds that pass before a purchase is made

var base_purchase_chance : float = 0.05 #percentage chance that an npc buys an available gem

# Called when the node enters the scene tree for the first time.
func _ready():
	curr_npc_count = 10 #test value for purchase engine
	
	var timer_purchase = $timer_purchase
	timer_purchase.connect("timeout", self, "_timer_purchase_timeout")
	
	timer_purchase.set_wait_time(time_base_purchase / curr_npc_count)
	timer_purchase.start()
	pass # Replace with function body.


func _timer_purchase_timeout():
	#run purchase throw
	_purchase_gems(curr_npc_count)
	
	var timer_purchase = $timer_purchase
	
	timer_purchase.set_wait_time(time_base_purchase / curr_npc_count)
	timer_purchase.start()
	return
	
func _purchase_gems(npc_count):
	for i in range(0, npc_count):
		var roll = randf()
		if roll < base_purchase_chance:
			print("purchase!!!")
	return
