extends Node2D

onready var state_machine = StateMachine.new()

func _ready():
	state_machine.initial_state = "States/PlayState"
