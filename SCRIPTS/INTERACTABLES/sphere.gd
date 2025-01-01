extends MeshInstance3D


@onready var green = preload("res://OTHERS/CARD_SCANNER2.tres")


func _on_card_scanner_color() -> void:
	set_surface_override_material(0, green)
