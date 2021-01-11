extends HBoxContainer

#script controls when to show gem storage containers or not


# Called when the node enters the scene tree for the first time.
func _ready():
	#check utility script and choose to show or hide container
	#depending on if user has unlocked them or not
	
	var unlock_dict_field = utility.unlock_dict_field
	
	if unlock_dict_field["gem_storage_small"] == true:
		$gem_storage_small.show()
		
	if unlock_dict_field["gem_storage_med"] == true:
		$gem_storage_med.show()
		
	if unlock_dict_field["gem_storage_large"] == true:
		$gem_storage_large.show()
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
