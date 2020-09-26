extends CheckBox


func _on_CheckBox_pressed() -> void:
	OS.window_fullscreen = !OS.window_fullscreen
