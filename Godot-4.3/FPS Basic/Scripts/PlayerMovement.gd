class_name PlayerMovementState

extends State

var PLAYER: Player
@export var ANIMATION: AnimationPlayer

func _ready():
	await owner.ready
	PLAYER = owner as Player
	ANIMATION = PLAYER.ANIMATION_PLAYER

func _process(delta):
	pass
