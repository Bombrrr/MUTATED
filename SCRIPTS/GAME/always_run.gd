extends Node

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("ui_cancel"):
		Global.paw = !Global.paw

func _process(delta: float) -> void:
	get_tree().paused = Global.paw
