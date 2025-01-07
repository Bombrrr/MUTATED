extends Node3D

signal close

@onready var loc = Vector3($door.global_position)
@onready var rot = $door/loc.global_rotation.y
@onready var num
@onready var div = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.global_position = Global.genloc
	self.global_rotation.y = Global.genrot
	rot = $door/loc.global_rotation.y
	loc = Vector3($door.global_position)
	loc.y = loc.y - 0.09
	Global.genrot = rot
	Global.genloc = loc
	num = Global.genromnum
	$door/SubViewport2/VBoxContainer/Label.text = var_to_str(Global.genromnum)
	Global.genromnum += 1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if num < (Global.genromnum - 4):
		self.queue_free()
	elif num < (Global.genromnum - 2):
		$"NavigationRegion3D/main objects/MeshInstance3D13".show()
		$"NavigationRegion3D/main objects/MeshInstance3D14".show()
		$"NavigationRegion3D/main objects/MeshInstance3D15".show()
		$door2.show()
		$door2.global_position.y = 0.091
		emit_signal("close")
