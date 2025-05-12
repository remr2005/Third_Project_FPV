extends Label

func _process(delta):
	var all_coins = get_tree().get_nodes_in_group("coins")
	var invisible_count = 0

	for coin in all_coins:
		if not coin.visible:
			invisible_count += 1

	text = "Собрано %d / %d" % [invisible_count, all_coins.size()]
func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
