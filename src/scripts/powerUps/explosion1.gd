extends Area2D

onready var sfx2I = preload("res://src/oth/sfx/explosion1sfx.tscn")

func _ready() -> void:
	var sfx = sfx2I.instance()
	sfx.set_position(get_position())
	get_tree().get_root().add_child(sfx)
	$AnimationPlayer.play("explosion1")
	yield(get_tree().create_timer(0.3), "timeout")
	var killGuys = get_overlapping_bodies()
	for i in killGuys:
		if i.is_in_group("enemy") || i.is_in_group("player"):
			if i.is_in_group("turret"):
				if i.is_in_group("add"):
					if Global.isReverse == true:
						i.health -= 50
				else:
					i.health -= 50
			elif i.is_in_group("GL"):
				pass
			else:
				i.health -= 50
				i.get_node("AnimationPlayer2").stop()
				i.get_node("AnimationPlayer2").play("playerDamage")
	yield(get_tree().create_timer(0.7), "timeout")
	queue_free()
