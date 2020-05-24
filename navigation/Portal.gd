extends Area2D

signal player_contact

const Player = preload("res://player/Player.gd")

export var destination = "res://tilemaps/default/default.tmx"

onready var collision_shape = $CollisionShape2D

func _ready():
	# Alter shape size from metadata
	if get_meta_list().size() > 0:
		if has_meta("width"):
			var rect : RectangleShape2D = collision_shape.shape as RectangleShape2D
			rect.extents.x = get_meta("width") / 2
		
		if has_meta("height"):
			var rect : RectangleShape2D = collision_shape.shape as RectangleShape2D
			rect.extents.y = get_meta("height") / 2
		
		if has_meta("destination"):
			destination = get_meta("destination")
	
	connect("body_entered", self, "_on_Area2D_body_entered")

func _on_Area2D_body_entered(body):
	if body is Player:
		emit_signal("player_contact", destination)
