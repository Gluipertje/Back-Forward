extends Button

func _on_Button_pressed() -> void:
	var sceneToChangeTo = get_tree().get_current_scene().get_name()
	get_tree().change_scene("res://src/scenes/level1_" + str(sceneToChangeTo)+".tscn")
