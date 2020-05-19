extends Area2D

const Player = preload("res://player/Player.gd")

func _ready():
	connect("body_entered", self, "_on_Area2D_body_entered")

func _on_Area2D_body_entered(body):
	if body is Player:
		var player = body as Player
		player.queue_free()
