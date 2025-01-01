extends Node3D

@export var is_top: bool = false
@onready var spawn_position
@onready var spawn = randi_range(1, 500)
@onready var spawn_location = randi_range(2, 5)
@onready var item
@onready var flask_s = preload("res://SCENES/BLUEPRINTS/FLASK/FLASK_SMALL.tscn")
@onready var flask_b = preload("res://SCENES/BLUEPRINTS/FLASK/FLASK_BIG.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if spawn < 333:
		spawn_flask(flask_s)
	elif spawn < 500:
		spawn_flask(flask_b)
	print(spawn)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func spawn_flask(type):
	item = type.instantiate()
	if spawn_location == 1:
		spawn_position = Vector3(self.position)
	else:
		spawn_position = Vector3(self.position)
	item.position = spawn_position
	print(item.position)
	add_child(item)
