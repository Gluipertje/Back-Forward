extends Node

var isReverse = false

func clearPOItem():
	if get_parent().has_node("grenadeHand"):
			get_parent().get_node("grenadeHand").queue_free()
			get_parent().get_parent().get_node("reverseCP").poType.erase("grenadeHand")
	elif get_parent().has_node("machineGun"):
		get_parent().get_node("machineGun").queue_free()
		get_parent().get_parent().get_node("reverseCP").poType.erase("machineGun")
