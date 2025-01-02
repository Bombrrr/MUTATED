extends Button
class_name RemapButton

@export var action: String
@export var key: String
@onready var first_press = false

func _init():
	toggle_mode = true
	theme_type_variation = "RemapButton"
	
	
func _ready() -> void:
	set_process_unhandled_input(false)
	update_key_text()
	
	
func _toggled(button_pressed):
	set_process_unhandled_input(button_pressed)
	if button_pressed:
		text = (action + ": UNBOUND")
		release_focus()
	else:
		update_key_text()
		grab_focus()
	
	
func _unhandled_input(event: InputEvent) -> void:
	if event.pressed:
		InputMap.action_erase_events(action)
		InputMap.action_add_event(action, event)
		first_press = true
		button_pressed = false
	
	
func update_key_text():
	if action == "interact":
		Global.interact = "%s" % InputMap.action_get_events(action)[0].as_text()
		print("%s" % InputMap.action_get_events(action)[0].as_text())
	text = action + ": " + "%s" % InputMap.action_get_events(action)[0].as_text()
