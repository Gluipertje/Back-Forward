extends Sprite

onready var grenadeI = preload("res://src/prefabs/powerUps/grenade.tscn")

var timer= Timer.new()
var _canShoot =true

func _ready() -> void:
	timer.set_wait_time(1)
	timer.connect("timeout", self, "timeout")
	add_child(timer)
	if get_parent().has_node("machineGun"):
		get_parent().get_node("machineGun").queue_free()
		get_parent().get_parent().get_node("reverseCP").poType.e("machineGun")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("lclick") && _canShoot:
		var grenade = grenadeI.instance()
		grenade.set_position(get_parent().get_position())
		grenade.apply_central_impulse((get_global_mouse_position() - get_parent().get_position()).normalized() * 700)
		get_parent().get_parent().add_child(grenade)
		_canShoot = false
		timer.start()

func timeout():
	_canShoot = true
