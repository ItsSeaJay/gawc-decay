class_name Player
extends KinematicBody2D

signal player_died

enum State {
	STATE_NORMAL,
	STATE_AIRBORNE,
}

export var movement_speed = 64
export var jump_height = 32
export var jump_duration : float = 2
export var terminal_velocity = 128

var state = State.STATE_NORMAL
var gravity
var jump_speed

onready var velocity = Vector2.ZERO
onready var velocity_final = Vector2.ZERO

func _ready():
	gravity = 2.0 * jump_height / pow(jump_duration / 2.0, 2.0)
	jump_speed = -sqrt(2.0 * gravity * jump_height)

func _physics_process(delta):
	match(state):
		State.STATE_NORMAL:
			process_movement(delta)
			process_jumping(delta)
			
			if not is_on_floor():
				transition(State.STATE_AIRBORNE)
		State.STATE_AIRBORNE:
			process_movement(delta)
			process_falling(delta)
			
			if is_on_floor():
				transition(State.STATE_NORMAL)
			
			if is_on_ceiling():
				velocity.y = 0
	
	velocity_final = move_and_slide(velocity, Vector2.UP)

func process_movement(delta):
	velocity.x = get_input_direction() * movement_speed

func process_jumping(delta):
	if Input.is_action_just_pressed("move_jump"):
		velocity.y = jump_speed

func process_falling(delta):
	velocity.y = min(velocity.y + gravity * delta, terminal_velocity)
	pass

func transition(state):
	match(state):
		State.STATE_NORMAL:
			pass
		State.STATE_AIRBORNE:
			pass
	
	self.state = state

func get_input_direction():
	return Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
