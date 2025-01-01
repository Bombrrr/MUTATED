extends Node3D

@onready var zombert: PackedScene = preload("res://SCENES/BLUEPRINTS/ZOMBERT.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	summon(zombert, 5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func summon(summon, ymod):
	var inst_summon = summon.instantiate()
	inst_summon.position = self.global_position
	inst_summon.position.y = self.global_position.y + ymod
	add_sibling(inst_summon)
