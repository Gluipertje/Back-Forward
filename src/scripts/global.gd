extends Node

var isReverse = false
var score = 0
var isDead = false
var isWon = false

func clearPOItem(player, accessPO):
	if player.has_node("grenadeHand") && accessPO != "grenadeHand":
		player.get_node("grenadeHand").queue_free()
		player.get_parent().get_node("reverseCP").poType.erase("grenadeHand")
		print("removed grenade")
		
	if player.has_node("machineGun") && accessPO != "machineGun":
		player.get_node("machineGun").queue_free()
		player.get_parent().get_node("reverseCP").poType.erase("machineGun")
		print("removed gun")
		
	if player.has_node("boxingGloves") && accessPO != "boxingGloves":
		player.get_node("boxingGloves").remove()
		player.get_parent().get_node("reverseCP").poType.erase("boxingGloves")
		print("removed gloves")
