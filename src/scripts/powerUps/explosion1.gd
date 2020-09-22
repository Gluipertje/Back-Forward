extends Area2D

func _ready() -> void:
	$AnimationPlayer.play("explosion1")
	yield(get_tree().create_timer(0.3), "timeout")
	var killGuys = get_overlapping_bodies()
	for i in killGuys:
		if i.is_in_group("enemy") || i.is_in_group("player"):
			if i.is_in_group("turret"):
				if Global.isReverse == true:
					i.health -= 50
			elif i.is_in_group("GL"):
				pass
			else:
				i.health -= 50
	yield(get_tree().create_timer(0.7), "timeout")
	queue_free()
