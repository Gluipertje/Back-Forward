extends Area2D

func _on_reverseCP_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.get_node("CanvasLayer/Control/ColorRect").set_environment(load("res://src/oth/pp_bloom.tres"))
		$Sprite.set_visible(false)
		$Sprite2.set_visible(true)
