extends Node

var ball: RigidBody2D = null
var is_game_started: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("start") && is_game_started == false:
		ball.start()
		is_game_started = true
		Events.game_started.emit()
		get_viewport().set_input_as_handled()
