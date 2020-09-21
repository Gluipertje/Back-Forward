extends Area2D

onready var reverseCP = get_parent().get_node("reverseCP")

func _on_startPoint_body_entered(body: Node) -> void:
	if body.is_in_group("player") && reverseCP.isReverse:
		print("u won!!")

func levelReverse():
	$Sprite.hide()
	$Sprite2.show()
