extends Node

var sprite2
var sprite3

func _ready() -> void:
	sprite2 = get_parent().get_node("Sprites/Sprite2")
	sprite3 = get_parent().get_node("Sprites/Sprite3")
	sprite2.show()
	sprite3.show()
	
