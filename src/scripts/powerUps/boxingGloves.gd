extends Node

var sprite2
var sprite3
var areaDeath
var animPlayer

var _canHit = true
var timer = Timer.new()

func _ready() -> void:
	sprite2 = get_parent().get_node("Sprites/Sprite2")
	sprite3 = get_parent().get_node("Sprites/Sprite3")
	areaDeath = get_parent().get_node("Area2D")
	animPlayer = get_parent().get_node("AnimationPlayer")
	sprite2.show()
	sprite3.show()
	timer.set_wait_time(0.6)
	timer.connect("timeout", self, "timeout")
	add_child(timer)
	Global.clearPOItem(get_parent(), "boxingGloves")
	
func _process(delta: float) -> void:
	var doMove = get_parent().doMove
	if Input.is_action_just_pressed("lclick") && _canHit && doMove:
		animPlayer.stop()
		animPlayer.play("attackMelee")
#		yield(animPlayer, "animation_finished()")
		var bodies = areaDeath.get_overlapping_bodies()
		_canHit = false
		timer.start()
		yield(get_tree().create_timer(0.2), "timeout")
		for i in bodies:
			if i.is_in_group("enemy"):
				if i.is_in_group("turret"):
					if Global.isReverse == true:
						i.health -= 20
				else:
					i.health -= 20
					i.get_node("AnimationPlayer2").stop()
					i.get_node("AnimationPlayer2").play("playerDamage")

func timeout():
	_canHit = true

func remove():
	sprite2.hide()
	sprite3.hide()
	queue_free()
