extends StaticBody2D

const Player = preload("res://player/Player.gd")

export var decay_speed = 1
var decay = false

onready var area2d = $Area2D

func _ready():
	area2d.connect("body_entered", self, "_on_StaticBody2D_entered")
	area2d.connect("body_exited", self, "_on_StaticBody2D_exited")

func _process(delta):
	if decay:
		scale -= Vector2(decay_speed, decay_speed) * delta
	
	if scale.x <= 0:
		queue_free()

func _on_StaticBody2D_entered(body):
	if body is Player:
		var player = body as Player
		decay = true

func _on_StaticBody2D_exited(body):
	if body is Player:
		var player = body as Player
		decay = false
