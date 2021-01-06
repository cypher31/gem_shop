extends TextureButton

#handles gem purchases
var gem_type : String
var gem_polished : bool
var gem_quality : String

# Called when the node enters the scene tree for the first time.
func _ready():
	utility.connect("purchase", self, "_purchase")
	pass # Replace with function body.


func _purchase(purchase_name, cost_dict):
	var gem = gem_type
	var cost = cost_dict[gem]
	var a #variable to get into polished or unpolished dictionary
	
	if gem_polished:
		a = "p"
	else:
		a = "up"
	
	if purchase_name == self.get_name():
		var gem_count = utility.gem_count_dict[gem][gem_quality][a]
		var gem_count_updated = gem_count - 1
		
		if gem_count_updated >= 0:
			utility.gem_count_dict[gem][gem_quality][a] = gem_count_updated
			print(gem_count_updated)
			utility.get_coin(null, cost)
	return
