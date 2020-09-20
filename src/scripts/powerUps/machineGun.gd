extends Node2D

var bulletI = preload("res://src/prefabs/bulletTurret.tscn")
var timer = Timer.new()

var _canShoot = true
var _i = 0

func _ready() -> void:
	timer.set_wait_time(0.2)
	timer.connect("timeout", self, "timeout")
	add_child(timer)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("lclick"):
		if _canShoot:
			var bullet = bulletI.instance()
			bullet.target = get_global_rotation()
			bullet.set_name("bullet1 " + str(_i))
			bullet.set_position(to_global($sp.get_position() + Vector2(60,0)))
			get_tree().get_root().add_child(bullet)
			_canShoot = false
			timer.start()
			_i += 1

func timeout():
	_canShoot = true
