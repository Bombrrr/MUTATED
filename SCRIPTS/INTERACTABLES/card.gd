extends Node3D

@onready var looked: bool = false
@onready var display = $interact_button


func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("interact") and looked:
		Global.card = true
		self.queue_free()


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("player"):
		looked = true
		display.show()


func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.is_in_group("player"):
		looked = false
		display.hide()
