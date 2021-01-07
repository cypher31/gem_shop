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
	_purchase_check()
	
	if purchase_name == self.get_name():
		var gem = gem_type
		var cost = cost_dict[gem]
		var a #variable to get into polished or unpolished dictionary
		
		if gem_polished:
			a = "p"
		else:
			a = "up"
	
	
		var gem_count = utility.gem_count_dict[gem][gem_quality][a]
		var gem_count_updated = gem_count - 1
		
		if gem_count_updated >= 0:
			utility.gem_count_dict[gem][gem_quality][a] = gem_count_updated
			print(gem_count_updated)
			utility.get_coin(null, cost)
	return

#function checks whether the item has any more things to sell, if not, then remove from purchase dict
func _purchase_check():
	var gt = gem_type
	var gp = gem_polished
	var gq = gem_quality
	var a : String
	
	if gp:
		a = "p"
	else:
		a = "up"
	
	if gt != null:
		var gem_count_left = utility.gem_count_dict[gt][gq][a]
		
		if gem_count_left == 0:
			if utility.purchase_dict.has(self.get_name()):
				utility.purchase_dict.erase(self.get_name())
				print(self.get_name() + " has been purged from purchase_dict")
	return
