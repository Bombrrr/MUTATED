extends Node3D




@onready var amount = 2
@onready var rand
@onready var rand_f
@onready var player: PackedScene = preload("res://SCENES/BLUEPRINTS/PLAYER/PLAYER.tscn")
@onready var room1: PackedScene = preload("res://SCENES/LEVELS/LEVEL_1.tscn")
@onready var room2: PackedScene = preload("res://SCENES/LEVELS/LEVEL_2.tscn")
@onready var room_i
@onready var first: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#summonpos(player, 0, 1, 0)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.generate == true:
		Global.generate = false
		room()

func room():
	choose_room()
	generate_room()


func choose_room():
	rand = randi_range(1, amount)
	if rand == 1:
		room_i = room1.instantiate()
	if rand == 2:
		room_i = room2.instantiate()

func generate_room():
	add_child(room_i)

func summonpos(summon, xpos, ypos, zpos):
	var inst_summon = summon.instantiate()
	inst_summon.position = Vector3(xpos, ypos, zpos)
	add_child(inst_summon)

func summonnode(summon, node):
	var inst_summon = summon.instantiate()
	inst_summon.position = node.global_position
	add_child(inst_summon)


func _on_timer_timeout() -> void:
	room()


func _on_node_3d_hi() -> void:
	room()
