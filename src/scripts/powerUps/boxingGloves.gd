extends Node

var sprite2
var sprite3
var areaDeath
var animPlayer

onready var sfxI = preload("res://src/oth/sfx/punch1sfx.tscn")
onready var sfx1I = preload("res://src/oth/sfx/punch2sfx.tscn")
onready var sfx2I = preload("res://src/oth/sfx/whoosh1sfx.tscn")

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
	if Input.is_action_just_pressed("lclick") && _canHit && doMove && !Global.isDead:
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
					if i.is_in_group("add"):
						if Global.isReverse == true:
							i.health -= 20
					else:
						i.health -= 20
				else:
					i.health -= 20
					if randi() % 2 == 1:
						var sfx = sfxI.instance()
						sfx.set_position(get_parent().get_position())
						get_tree().get_root().add_child(sfx)
					else:
						var sfx1 = sfx1I.instance()
						sfx1.set_position(get_parent().get_position())
						get_tree().get_root().add_child(sfx1)
					i.get_node("AnimationPlayer2").stop()
					i.get_node("AnimationPlayer2").play("playerDamage")
		
		var sfx2 = sfx2I.instance()
		sfx2.set_position(get_parent().get_position())
		get_tree().get_root().add_child(sfx2)

func timeout():
	_canHit = true

func remove():
	sprite2.hide()
	sprite3.hide()
	queue_free()
