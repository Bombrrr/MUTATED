extends Node3D

@export_range(0, 1000) var small_chance = 1000
@export_range(1, 1000) var range: int = 1000
@onready var type: bool = false
@onready var spawn = randi_range(1, 1000)
@onready var spawn_location = randi_range(1, 5)
@onready var opened = false
@onready var display = $Cube_005/interact_button
@onready var looked: bool = false
@onready var state: bool = false
@onready var anim = $AnimationPlayer2
@onready var bt = $FLASK_B_T
@onready var bd = $Cube_005/FLASK_B_D
@onready var st  = $FLASK
@onready var sd = $Cube_005/FLASK

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	small_chance += 1
	keep_flask()


func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("interact") and !anim.is_playing() and looked:
		state = !state
		if state:
			if opened:
				anim.play("OPEN_O", -1, 18)
			else:
				anim.play("OPEN", -1, 18)
		else:
			anim.play("CLOSE", -1, 18)
		opened = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_drawer_detection_area_entered(area: Area3D) -> void:
	if area.is_in_group("player"):
		looked = true
		display.show()


func _on_drawer_detection_area_exited(area: Area3D) -> void:
	if area.is_in_group("player"):
		looked = false
		display.hide()

#triggers functions to choose the flask to keep
func keep_flask():
	remove_type()
	remove_location()

#removes the location not chosen
func remove_location():
	if spawn_location == 1:
		if type:
			sd.queue_free()
		else:
			bd.queue_free()
	else:
		if type:
			st.queue_free()
		else:
			bt.queue_free()

#decides what size to keep
func remove_type():
	if spawn < small_chance:
		type = true
		delete_big()
	elif spawn < range:
		delete_small()
	else:
		delete_big()
		delete_small()

#deletes the size not chosen to keep
func delete_big():
	bd.queue_free()
	bt.queue_free()

func delete_small():
	sd.queue_free()
	st.queue_free()
