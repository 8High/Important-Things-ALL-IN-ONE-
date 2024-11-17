class_name Player

extends CharacterBody3D

# Exports

@export_group("Player Assignments")
@export var CAMERA : Camera3D
@export var ANIMATION_PLAYER : AnimationPlayer

@export_group("Values")
@export_subgroup("Walk")
@export var WALKING_SPEED : float = 4.5
@export var ACCELERATION : float = 0.1
@export var DECELERATION : float = 0.25
@export_subgroup("Sprint")
@export var SPRINTING_SPEED : float = 7.0
@export_subgroup("Crouch")
@export var CROUCH_SHAPECAST : Node3D

@export_group("Head Movement")
@export_subgroup("Head")
@export var MOUSE_SENSITIVITY : float = 0.25
@export_subgroup("Clamp")
@export var UPPER_CLAMP_LIMIT = deg_to_rad(-89.0)
@export var LOWER_CLAMP_LIMIT = deg_to_rad(89.0)

# Variables

var currentSpeed = WALKING_SPEED

# State Machine Variables 

var isCrouching : bool = false
var isPeakingLeft : bool = false
var isPeakingRight : bool = false

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Ready Functions 

func _ready():
	
	Global.player = self
	
	CROUCH_SHAPECAST.add_exception($".")

# Input Functions

func _input(event):
	if event is InputEventScreenDrag:
		if event.position.x >= get_viewport().size.x/2.0:
			rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENSITIVITY))
			CAMERA.rotate_x(deg_to_rad(-event.relative.y * MOUSE_SENSITIVITY))
			CAMERA.rotation.x = clamp(CAMERA.rotation.x,UPPER_CLAMP_LIMIT, LOWER_CLAMP_LIMIT)
	

# Physics Functions

func _physics_process(delta):
	
	
	Global.debug.add_property("Movement Speed", currentSpeed, 1)
	Global.debug.add_property("Velocity","%.2f" % velocity.length(), 2)

func update_gravity(delta) -> void:
	velocity.y -= gravity * delta
	
func update_input(speed: float, acceleration: float, deceleration: float) -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = lerp(velocity.x,direction.x * speed, acceleration)
		velocity.z = lerp(velocity.z,direction.z * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)
	
func update_velocity() -> void:
	move_and_slide()
