extends CanvasLayer

func _physics_process(delta: float) -> void:
	if Global.paw:
		show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
