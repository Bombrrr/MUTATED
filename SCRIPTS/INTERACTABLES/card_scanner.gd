extends Node3D

signal color

@onready var interacted: bool = false
@onready var card = $Cube_001
@onready var looked: bool = false
@onready var display = $interact_button
@onready var anim = $AnimationPlayer

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("interact") and not interacted and looked:
		emit_signal("color")
		display.hide()
		card.show()
		anim.play("Cube_001Action")
		interacted = true


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("player"):
		looked = true
		if not interacted:
			display.show()


func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.is_in_group("player"):
		looked = false
		if not interacted:
			display.hide()
