extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var bucket_1 = $gem_bucket_1
	var bucket_2 = $gem_bucket_2
	var bucket_3 = $gem_bucket_3
	
	if utility.unlock_dict["gem_bucket_1"] == true:
		bucket_1.show()
		
	if utility.unlock_dict["gem_bucket_2"] == true:
		bucket_2.show()
		
	if utility.unlock_dict["gem_bucket_3"] == true:
		bucket_3.show()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
