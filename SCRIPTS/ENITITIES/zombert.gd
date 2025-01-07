extends CharacterBody3D

@onready var nav = $NavigationAgent3D
@onready var targ: bool = false
@onready var can_hit: bool = true

const speed = 3.0
const JUMP_VELOCITY = 4.5
func _ready() -> void:
	$"zombert model/AnimationPlayer".play("metarigAction_001")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	else:
		velocity.y -=2
	var next_location = nav.get_next_path_position()
	var current_location = global_transform.origin
	var new_velocity = (next_location - current_location).normalized() * speed
	look_at(Vector3(nav.target_position.x, global_position.y, nav.target_position.z))
	if targ:
		velocity = velocity.move_toward(new_velocity,0.25)
		move_and_slide()
	if velocity.x > 0 or velocity.z > 0:
		$"zombert model/AnimationPlayer".play("metarigAction_001")
	

func target_position(target):
	nav.target_position = target

func entered(state):
	if state == true and nav.is_target_reachable:
		targ = true
	else:
		targ = false


func _on_area_3d_area_entered(area: Area3D) -> void:
	if can_hit and area.is_in_group("play"):
		can_hit = false
		get_tree().call_group("play", "damage", 5)
		$Timer.start(1)


func _on_timer_timeout() -> void:
	can_hit = true
