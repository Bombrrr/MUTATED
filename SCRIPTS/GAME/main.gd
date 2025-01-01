extends Node3D

signal close

@onready var loc = Vector3($door.global_position)
@onready var num


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.global_position = Global.genloc
	loc = Vector3($door.global_position)
	loc.y = loc.y - 0.09
	Global.genloc = loc
	num = Global.genromnum
	$door/SubViewport/Label.text = var_to_str(Global.genromnum)
	Global.genromnum += 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if num < (Global.genromnum - 1):
		Global.back_loc = self.global_position
	if num < (Global.genromnum - 8):
		self.queue_free()
	elif num < (Global.genromnum - 2):
		if $"../CharacterBody3D".global_position.x < self.global_position.x:
			$"../CharacterBody3D".global_position = Global.back_loc
		$door2.show()
		$door2.global_position.y = 0.091
		emit_signal("close")
