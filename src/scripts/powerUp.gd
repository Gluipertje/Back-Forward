extends Area2D

export var powerType = "machineGun"
export var spritePath = preload("res://assets/sprites/items/weapon1sv.png")

var powerUpI

func _ready() -> void:
	$Sprite.set_texture(spritePath)
	var puPath = "res://src/prefabs/powerUps/" + powerType + ".tscn"
	powerUpI = load(puPath)
	$AnimationPlayer.play("itemFloat")

func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		var powerUp = powerUpI.instance()
		body.add_child(powerUp)
		queue_free()
