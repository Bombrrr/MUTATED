extends Area3D




func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("play"):
		get_tree().call_group("enemy", "entered", true)
		print("ent")

func _on_area_exited(area: Area3D) -> void:
	if area.is_in_group("play"):
		get_tree().call_group("enemy", "entered", false)
		print("ex")
