extends Node

var timer = Timer.new()

func _ready() -> void:
	get_parent().speed = get_parent().speed * 2
	timer.set_wait_time(3)
	timer.connect("timeout", self, "timeout")
	add_child(timer)
	timer.start()

func timeout():
	get_parent().speed -= get_parent().speed / 2
	print(get_parent().speed)
	queue_free()
