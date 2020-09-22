extends StaticBody2D

var _canShoot = true
var _playerDis
var state
var _isDead = false
var i
var health
var shouldShoot = true

var timer = Timer.new()
onready var player = get_parent().get_node("player")
var bulletI = preload("res://src/prefabs/bulletTurret.tscn")

export var shootSpeed = 0.1
export var maxHealth = 50
export var detectionRange = 500

enum {
	IDLE,
	SHOOT
}

func _ready() -> void:
	timer.set_wait_time(shootSpeed)
	timer.connect("timeout", self, "timeout")
	add_child(timer)
	state = IDLE
	health = maxHealth
	if is_in_group("add"):
		shouldShoot = false
	

func _process(delta: float) -> void:
	if health < 1 && !_isDead:
		$Sprite.queue_free()
		$CollisionShape2D.queue_free()
		_isDead = true
	_playerDis = get_position().distance_to(player.get_position())
	if _playerDis < detectionRange && shouldShoot:
		state = SHOOT
	else:
		state = IDLE
	
	match state:	
		SHOOT:
			if shouldShoot:
				look_at(player.get_position())
				$Sprite2.set_global_rotation(0)
				if _canShoot && !_isDead:
					var bullet = bulletI.instance()
					bullet.target = get_global_rotation()
					bullet.set_name("bullet1 " + str(i))
					bullet.set_position(to_global($sp.get_position()))
					get_parent().get_parent().add_child(bullet)
					_canShoot = false
					timer.start()
		IDLE:
			pass
		
func timeout():
	_canShoot = true
