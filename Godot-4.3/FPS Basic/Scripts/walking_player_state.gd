class_name WalkingPlayerState

extends PlayerMovementState

@export var WALKING_SPEED : float = 4.5
@export var ACCELERATION : float = 0.1
@export var DECELERATION : float = 0.25
@export var TOP_ANIM_SPEED: float = 1.0

func enter() -> void:
	ANIMATION.play("Walking", -1.0, 1.0)
	Global.player.currentSpeed = Global.player.WALKING_SPEED

func update(delta):
	set_animation_speed(Global.player.velocity.length())
	if Global.player.velocity.length() == 0.0:
		transition.emit("IdlePlayerState")
		

func set_animation_speed(spd):
	var alpha = remap(spd, 0.0, Global.player.WALKING_SPEED, 0.0, 1.0)
	ANIMATION.speed_scale = lerp(0.0, TOP_ANIM_SPEED, alpha)

func _input(event):
	if event.is_action_pressed("Sprint") and Global.player.is_on_floor():
		transition.emit("SprintingPlayerState")
