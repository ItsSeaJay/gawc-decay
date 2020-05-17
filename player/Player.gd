class_name Player
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

var state = State.STATE_NORMAL
var gravity
var jump_speed

onready var velocity = Vector2.ZERO
onready var velocity_final = Vector2.ZERO

func _ready():
	gravity = 2 * jump_height / pow(jump_duration, 2)
	jump_speed = -sqrt(2 * gravity * jump_height)

func _physics_process(delta):
	match(state):
		State.STATE_NORMAL:
			process_movement()
			process_jumping()
			
			if not is_on_floor():
				transition(State.STATE_AIRBORNE)
		State.STATE_AIRBORNE:
			process_movement()
			process_falling()
			
			if is_on_floor():
				transition(State.STATE_NORMAL)
	
	velocity_final = move_and_slide(velocity)

func process_movement():
	velocity.x = get_input_direction() * movement_speed

func process_jumping():
	if Input.is_action_just_pressed("move_jump"):
		velocity.y = -jump_speed

func process_falling():
	velocity.y = min(velocity.y + gravity, terminal_velocity)

func transition(state):
	match(state):
		State.STATE_NORMAL:
			pass
		State.STATE_AIRBORNE:
			pass
	
	self.state = state

func get_input_direction():
	return Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
