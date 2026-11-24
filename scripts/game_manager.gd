extends Node

const POINTS_To_WIN: int = 2

var ball: RigidBody2D = null
var is_game_started: bool = false

var _player_score: int = 0
var _opponent_score: int = 0


func _ready() -> void:
	pass




func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("start") && is_game_started == false:
		ball.start()
		is_game_started = true
		Events.game_started.emit()
		get_viewport().set_input_as_handled()
