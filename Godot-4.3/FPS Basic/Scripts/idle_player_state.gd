class_name IdlePlayerState

extends PlayerMovementState

func enter():
	ANIMATION.pause()

func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input()
	PLAYER.update_velocity()
	
	if Global.player.velocity.length() > 0.0 and Global.player.is_on_floor():
		transition.emit("WalkingPlayerState")
