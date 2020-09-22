extends Sprite

onready var grenadeI = preload("res://src/prefabs/powerUps/grenade.tscn")

var timer= Timer.new()
var _canShoot =true

func _ready() -> void:
	Global.clearPOItem(get_parent(), "grenadeHand")
	timer.set_wait_time(1)
	timer.connect("timeout", self, "timeout")
	add_child(timer)

func _process(delta: float) -> void:
	var doMove = get_parent().doMove
	if Input.is_action_just_pressed("lclick") && _canShoot && doMove:
		var grenade = grenadeI.instance()
		grenade.set_position(get_parent().get_position())
		grenade.apply_central_impulse((get_global_mouse_position() - get_parent().get_position()).normalized() * 700)
		get_parent().get_parent().add_child(grenade)
		_canShoot = false
		timer.start()

func timeout():
	_canShoot = true
