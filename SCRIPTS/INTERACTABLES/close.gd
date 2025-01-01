extends Node3D

@onready var first: bool = true

func _on_visibility_changed() -> void:
	if first:
		first = false
		self.hide()
		$AnimationPlayer.play_backwards("ArmatureAction")
		$Timer.start(0.1)
		print("hi")


func _on_timer_timeout() -> void:
	self.show()
