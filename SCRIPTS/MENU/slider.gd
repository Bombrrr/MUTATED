extends HSlider

@onready var val

func _on_drag_ended(value_changed: bool) -> void:
	val = round(value)
	$"../SENSITIVITY".text = "MOUSE SENSITIVITY:" + var_to_str(val)
	Global.sensitivity = val


func _on_value_changed(value: float) -> void:
	val = round(value)
	$"../FOV".text = "FOV:" + var_to_str(val)
	Global.fov = val
