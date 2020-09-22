extends Area2D

onready var reverseCP = get_parent().get_node("reverseCP")
onready var wonScreenI = preload("res://src/prefabs/UI/wonScreen.tscn")

func _on_startPoint_body_entered(body: Node) -> void:
	if body.is_in_group("player") && reverseCP.isReverse:
		var wonScreen = wonScreenI.instance()
		get_parent().get_node("player/CanvasLayer/Control").add_child(wonScreen)
		get_parent().get_node("player").doMove = false

func levelReverse():
	$Sprite.hide()
	$Sprite2.show()
