extends Button

export var leveltoswitch = ""


func _on_Button_pressed() -> void:
	get_tree().change_scene(leveltoswitch)


func _on_Button2_pressed() -> void:
	get_tree().change_scene(leveltoswitch)
