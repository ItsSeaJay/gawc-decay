extends Node
class_name AudioSystem

var sounds = []

func play_sound(path, options={}):
	var player
	
	if options.has("position"):
		player = AudioStreamPlayer2D.new()
		player.position = options["position"]
	else:
		player = AudioStreamPlayer.new()
	
	player.stream = load(path)
	player.autoplay = true
	
	if options.has("pitch_scale"):
		player.pitch_scale = options["pitch_scale"]
	
	if options.has("mix_target"):
		player.mix_target = options["mix_target"]
	
	if options.has("bus"):
		player.bus = options["bus"]
	
	get_tree().root.add_child(player)
	sounds.push_back(player)
	
	# Ensure the player is cleaned up after use
	player.connect("finished", self, "_on_playback_finished", [ player ])
	
	return player

func _on_playback_finished(player):
	player.queue_free()
