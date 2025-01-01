extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start(0.1)


func _on_timer_timeout() -> void:
	text = "[" + Global.interact + "]"
