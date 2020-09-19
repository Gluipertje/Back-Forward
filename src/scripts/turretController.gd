extends StaticBody2D

var _canShoot = true
var _playerDis
var _state
var i

var timer = Timer.new()
onready var player = get_parent().get_node("player")
var bulletI = preload("res://src/prefabs/bulletTurret.tscn")

enum {
	IDLE,
	SHOOT
}

func _ready() -> void:
	timer.set_wait_time(1.0)
	timer.connect("timeout", self, "timeout")
	add_child(timer)
	_state = IDLE

func _process(delta: float) -> void:
	_playerDis = get_position().distance_to(player.get_position())
	if _playerDis < 500:
		_state = SHOOT
	else:
		_state = IDLE
	
	match _state:	
		SHOOT:
			look_at(player.get_position())
			if _canShoot:
				var bullet = bulletI.instance()
				bullet.target = player.get_position()
				bullet.set_name("bullet1 " + str(i))
				bullet.set_position(to_global($sp.get_position()))
				get_parent().add_child(bullet)
				_canShoot = false
				timer.start()
		IDLE:
			pass
		
func timeout():
	_canShoot = true
