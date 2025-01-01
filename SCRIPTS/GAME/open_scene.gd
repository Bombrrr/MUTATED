extends Button
@export var scene_path: String
@export var captured: bool
func _on_pressed() -> void:
	Global.paw = false
	get_tree().paused = Global.paw
	get_tree().change_scene_to_file(scene_path)
	if captured == true: Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
