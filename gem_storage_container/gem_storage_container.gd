extends Control

var max_gem_count_small : int = 9 #total number of gems this contianer can hold
export var container_size : String #size of the storage container


# Called when the node enters the scene tree for the first time.
func _ready():
	if container_size == "small":
		utility.gem_small_container = self
	
	if container_size == "med":
		utility.gem_med_container = self
		
	if container_size == "large":
		utility.gem_large_container = self
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
