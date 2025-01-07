extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "score:\n" + var_to_str(floor(Global.point/100))
	$Timer.start(7.5)


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://SCENES/MENU/MENU.tscn")
