extends Node

var timer = Timer.new()

func _ready() -> void:
	get_parent().speed = get_parent().speed * 1.8
