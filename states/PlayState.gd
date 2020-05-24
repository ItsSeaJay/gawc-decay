extends "res://state_machine/State.gd"
class_name PlayState

var portals = []

func _ready():
	update_portals()

func update_portals():
	portals = get_tree().get_nodes_in_group("portal")
	
	for portal in portals:
		portal.connect("player_contact", self, "_on_Portal_player_contact")

func _on_Portal_player_contact(destination):
	for child in $MapRoot.get_children():
		child.queue_free()
	
	$MapRoot.add_child(load(destination).instance())
	
