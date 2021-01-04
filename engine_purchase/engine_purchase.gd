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

#bucket inventory, signal gets sent to this node with bucket info
var gem_bucket_1 : String = "empty"
var gem_bucket_2 : String = "empty"
var gem_bucket_3 : String = "empty"

# Called when the node enters the scene tree for the first time.
func _ready():
	utility.connect("bucket_set", self, "_bucket_set")
	curr_npc_count = 10 #test value for purchase engine
	
	var timer_purchase = $timer_purchase
	timer_purchase.connect("timeout", self, "_timer_purchase_timeout")
	
	timer_purchase.set_wait_time(time_base_purchase / curr_npc_count)
	timer_purchase.start()
	pass # Replace with function body.


func _timer_purchase_timeout():
	#check if run purchase throw is allowed
	if gem_bucket_1 != "empty" or gem_bucket_2 != "empty" or gem_bucket_3 != "empty":
		_purchase_gems(curr_npc_count)
	else:
		print("nothing to buy!!!")
	
	var timer_purchase = $timer_purchase
	
	timer_purchase.set_wait_time(time_base_purchase / curr_npc_count)
	timer_purchase.start()
	return
	
func _purchase_gems(npc_count):
	var bucket_array : Array
	
	if gem_bucket_1 != "empty":
		bucket_array.append(gem_bucket_1)
	elif gem_bucket_2 != "empty":
		bucket_array.append(gem_bucket_2)
	elif gem_bucket_3 != "empty":
		bucket_array.append(gem_bucket_3)
	
	for i in range(0, npc_count):
		var roll = randf()
		var rand_bucket = randi() % (bucket_array.size())
		var gem_count_dict : Dictionary = utility.gem_count_dict
		
		if roll < base_purchase_chance:
			#need to pass whether gem is poloshed or unpolished as well
	return
	
#set the gem bucket in the purchase engine after user sets in their store (signal from purchase counter)
func _bucket_set(bucket_name, gem_type):
	if bucket_name == "gem_bucket_1":
		gem_bucket_1 = gem_type
	elif bucket_name == "gem_bucket_2":
		gem_bucket_2 = gem_type
	elif bucket_name == "gem_bucket_3":
		gem_bucket_3 = gem_type
	return
