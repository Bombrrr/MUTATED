extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_card_scanner_color() -> void:
	$"../Area3D".queue_free()
	get_tree().call_group("enemy", "entered", false)
	$Timer.start(3)


func _on_timer_timeout() -> void:
	$AnimationPlayer.play("ArmatureAction")
	$StaticBody3D.queue_free()
	Global.generate = true
