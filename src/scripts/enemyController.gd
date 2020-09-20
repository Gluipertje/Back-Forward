extends KinematicBody2D

var _collider
var _canAttack = true
var _velocity = Vector2(0,0)
var _playerDis

onready var player = get_parent().get_node("player")
var timer = Timer.new()
var health

export var speed = 200
export var attackDamage = 10
export var maxHealth = 50
export var detectionRange = 500

func _ready() -> void:
	health = maxHealth
	timer.set_wait_time(1.0)
	timer.connect("timeout", self, "timeout")
	add_child(timer)

func _process(delta: float) -> void:
	_playerDis = get_position().distance_to(player.get_position())
	Engine.set_time_scale(1)
	
#	if _playerDis < 290:	
#		Engine.set_time_scale((_playerDis/290))
	if health < 1:
		Engine.set_time_scale(1)
		queue_free()
		
	if _playerDis <= 100 && _canAttack:
		player.health -= attackDamage
		$AnimationPlayer.stop(true)
		randomize()
		if randi() % 100 < 50:
			$AnimationPlayer.play("enemyAttack1")
		else:
			$AnimationPlayer.play("enemyAttack2")
		_canAttack = false
		timer.start()
		
	if _playerDis < detectionRange && _playerDis >= 100:
		_velocity = to_local(player.get_position()).normalized() * speed
		$Sprite.look_at(player.get_position())
	else:
		_velocity = Vector2(0,0)
		
	if _playerDis > 80:
		move_and_slide(_velocity)

func timeout():
	_canAttack = true
