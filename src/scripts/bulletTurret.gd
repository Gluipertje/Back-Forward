extends Area2D

export var bulletSpeed = 10
export var bulletDamage = 18
export var bulletSize = 1
export var launchAngle = 0
export var target = Vector2()
export var rotate = 0
export var damageDrop = 0.01

func _ready():
	set_rotation(target)
	set_rotation(get_rotation() + rotate)
	set_scale(Vector2(bulletSize, bulletSize))

func _process(delta):
	move_local_x(bulletSpeed * delta * 100)	
	bulletDamage -= damageDrop

func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("enemy") || body.is_in_group("player"):
		if body.is_in_group("turret"):
			if body.is_in_group("add"):
				if Global.isReverse == true:
					body.health -= bulletDamage
			else:
				body.health -= bulletDamage
		else:
			body.health -= bulletDamage
			body.get_node("AnimationPlayer2").stop()
			body.get_node("AnimationPlayer2").play("playerDamage")
	queue_free()
