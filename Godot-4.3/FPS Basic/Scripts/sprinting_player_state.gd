class_name SprintingPlayerState

extends PlayerMovementState

@export var TOP_ANIM_SPEED: float = 1.0

func enter():
	ANIMATION.play("Sprinting", -1.0, 1.0)
	Global.player.currentSpeed = Global.player.SPRINTING_SPEED

func update(delta):
	set_animation_speed(Global.player.velocity.length())

func set_animation_speed(spd):
	var alpha = remap(spd, 0.0, Global.player.SPRINTING_SPEED, 0.0, 1.0)
	ANIMATION.speed_scale = lerp(0.0, TOP_ANIM_SPEED, alpha)

func _input(event):
	if event.is_action_released("Sprint"):
		transition.emit("WalkingPlayerState")
