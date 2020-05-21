class_name Player
extends KinematicBody2D

signal player_died

enum State {
	STATE_NORMAL,
	STATE_AIRBORNE,
}

const PauseMenu = preload("res://interface/screens/PauseMenu.tscn")

export var movement_speed = 96
export var jump_height = 50
export var jump_duration : float = 0.66
export var jump_cancel_speed : float = 0
export var terminal_velocity = 222

var state = State.STATE_NORMAL
var gravity
var jump_speed

onready var velocity = Vector2.ZERO
onready var velocity_final = Vector2.ZERO

func _ready():
	assert(movement_speed > 0)
	assert(jump_height > 0)
	assert(jump_duration > 0)
	
	# Calculate jumping variables
	gravity = 2.0 * jump_height / pow(jump_duration / 2.0, 2.0)
	jump_speed = -sqrt(2.0 * gravity * jump_height)

func _process(delta):
	if Input.is_action_just_pressed("ui_pause"):
		var instance = PauseMenu.instance()
		get_tree().root.add_child(instance)
	
	if position.y > get_viewport().size.y:
		die()

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
			process_jump_cancel(delta)
			
			if is_on_ceiling():
				velocity.y = 0
			
			if is_on_floor():
				transition(State.STATE_NORMAL)
	
	velocity_final = move_and_slide(velocity, Vector2.UP)

func process_movement(delta):
	velocity.x = get_input_direction() * movement_speed

func process_jumping(delta):
	if Input.is_action_just_pressed("move_jump"):
		velocity.y = jump_speed

func process_jump_cancel(delta):
	if velocity.y < 0:
		if Input.is_action_just_released("move_jump"):
			velocity.y = jump_cancel_speed

func process_falling(delta):
	velocity.y = min(velocity.y + gravity * delta, terminal_velocity)

func die():
	queue_free()

func transition(state):
	match(state):
		State.STATE_NORMAL:
			pass
		State.STATE_AIRBORNE:
			pass
	
	self.state = state

func get_input_direction():
	return Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
