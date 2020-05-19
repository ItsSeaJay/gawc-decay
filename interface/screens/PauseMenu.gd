extends Control

onready var resume_button = $PanelContainer/MarginContainer/VBoxContainer/ResumeButton
onready var quit_button = $PanelContainer/MarginContainer/VBoxContainer/QuitButton

func _ready():
	# Pause the game
	get_tree().paused = true
	
	# Connect UI events
	resume_button.connect("button_down", self, "_on_ResumeButton_down")
	quit_button.connect("button_down", self, "_on_QuitButton_down")

func _on_ResumeButton_down():
	queue_free()
	get_tree().paused = false

func _on_QuitButton_down():
	get_tree().quit()
