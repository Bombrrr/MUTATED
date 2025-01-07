extends Node3D


@export_range(1, 3) var size : int = 1
@onready var display = $interact_button
@onready var looked: bool = false

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("interact") and looked:
		Global.data += size
		Global.point += size * 5
		self.queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("player"):
		looked = true
		display.show()


func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.is_in_group("player"):
		looked = false
		display.hide()


func _on_detection_area_entered(area: Area3D) -> void:
	pass # Replace with function body.
