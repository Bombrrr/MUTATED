extends Button


@export var type: String


func _on_pressed() -> void:
	if type == "sprint":
		Global.sprint_toggle = !Global.sprint_toggle
		
		if Global.sprint_toggle:
			text = "SPRINT: TOGGLE"
		else:
			text = "SPRINT: HOLD"

	if type == "crouch":
		Global.crouch_toggle = !Global.crouch_toggle
		
		if Global.crouch_toggle:
			text = "CROUCH: TOGGLE"
		else:
			text = "CROUCH: HOLD"
		print(Global.crouch_toggle)
