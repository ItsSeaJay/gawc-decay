extends KinematicBody2D

signal player_died

enum State {
	STATE_NORMAL,
	STATE_AIRBORNE,
}

export var movement_speed = 64
export var jump_height = 32
export var jump_duration = 0.48
export var terminal_velocity = 128

var velocity
var state = State.STATE_NORMAL
var gravity

func _ready():
	gravity = 2 * jump_height / pow(jump_duration, 2)

func _physics_process(delta):
	match(state):
		State.STATE_NORMAL:
			process_movement()

func process_movement():
	var linear_velocity = Vector2(get_movement_strength() * movement_speed, 0)
	velocity = move_and_slide(linear_velocity)

func get_movement_strength():
	return (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
