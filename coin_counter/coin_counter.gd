extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	utility.coin_count_label = self
	set_text(str(utility.coin_count))
	pass # Replace with function body.

