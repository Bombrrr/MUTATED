extends Node3D

@onready var loc = Vector3($door.global_position)
@onready var rot = $door/loc.global_rotation.y
@onready var num = 0
@onready var div = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rot = $door/loc.global_rotation.y
	loc = Vector3($door.global_position)
	loc.y = loc.y - 0.09
	Global.genrot = rot
	Global.genloc = loc
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if num < (Global.genromnum - 4):
		self.queue_free()
