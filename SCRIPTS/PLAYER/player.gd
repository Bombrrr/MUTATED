extends CharacterBody3D


@onready var sprint: bool = false
@export var toggle_crouch: bool = false
@export var toggle_sprint: bool = false
@onready var crouch: bool = false
@onready var sliding: bool = false
@onready var left = KEY_A

const base_speed = 2.5
const JUMP_VELOCITY = 4.5


@onready var speed = base_speed
# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var neck := $Neck
@onready var camera := $Neck/Camera3d
@onready var input_dir := Input.get_vector("left","right","forward","backward")
@onready var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()


func _ready() -> void:
	$Neck/Camera3d.fov = Global.fov
	toggle_crouch = Global.crouch_toggle
	toggle_sprint = Global.sprint_toggle
	crouch = false
	$ShapeCast3D.add_exception($".")


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.01 * Global.sensitivity * 0.01)
			camera.rotate_x(-event.relative.y * 0.01 * Global.sensitivity * 0.01)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(80))


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("crouch"):
		_toggle_crouch()
	if event.is_action_pressed("crouch") and not crouch and is_on_floor() and not toggle_crouch:
		crouching(true)
	if event.is_action_released("crouch") and is_on_floor() and not toggle_crouch:
		if not $ShapeCast3D.is_colliding():
			crouching(false)
		else:
			uncrouch_check()
	
	
func _physics_process(delta: float) -> void:
	
	#Scanner text
	if Global.card_needed:
		$Control/UI/Label2.show()
	else:
		$Control/UI/Label2.hide()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and not crouch:
		velocity.y = JUMP_VELOCITY


	#Handle Sprint.
	if not toggle_sprint:
		sprint = false
	
	if Input.is_action_pressed("sprint") and not crouch and not toggle_sprint:
		sprint = true
	
	if Input.is_action_just_released("sprint") and not crouch and toggle_sprint:
		sprint = !sprint
		
	if sprint:
		speed += (base_speed*2 - speed)*0.3
	elif  crouch:
		speed = base_speed * 0.5
	else:
		speed = base_speed
	
	#Handle Crouch and Slide.

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	input_dir = Input.get_vector("left","right","forward","backward")
	if not sliding:
		direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func _toggle_crouch():
	if crouch and not $ShapeCast3D.is_colliding() and is_on_floor():
		crouching(false)
	elif not crouch:
		crouching(true)

func uncrouch_check():
	if not $ShapeCast3D.is_colliding():
		crouching(false)
	else:
		await get_tree().create_timer(0.1).timeout
		uncrouch_check()

func crouching(state: bool):
	match state:
		true:
			$AnimationPlayer.play("crouch", -1, 7)
			sprint = false
			crouch = true
		false:
			$AnimationPlayer.play("crouch", -1, -7, true)
			crouch = false


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	if anim_name == "crouch":
		crouch = !crouch
