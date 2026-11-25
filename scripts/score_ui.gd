class_name ScoreUIController
extends CanvasLayer


var player_score: int = 0
var opponent_score: int = 0

@onready var player_score_label: Label = $TopBar/Scores/PlayerSide/PlayerScore
@onready var opponent_score_label: Label = $TopBar/Scores/OpponentSide/OpponentScore

@onready var game_over: CenterContainer = $GameOver
@onready var winner_label: Label = $GameOver/PanelContainer/VBoxContainer/WinnerLabel
@onready var restart_hint: Label = $GameOver/PanelContainer/VBoxContainer/RestartHint


func _update_score() -> void:
	player_score_label.text = str(player_score)
	opponent_score_label.text = str(opponent_score)


func _ready() -> void:
	game_over.hide()
	restart_hint.hide()
	_update_score()


func player_hit_ball() -> void:
	player_score += 2
	_update_score()


func opponent_hit_ball() -> void:
	opponent_score += 1
	_update_score()


func player_missed() -> void:
	player_score -= 3
	opponent_score += 5
	_update_score()
	GameManager.ball.hide()


func opponent_missed() -> void:
	opponent_score -= 2
	player_score += 5
	_update_score()
	GameManager.ball.hide()


func reset_game() -> void:
	player_score = 0
	opponent_score = 0
	_update_score()
	game_over.hide()
	GameManager.is_game_started = false
	GameManager.ball.freeze = true
	GameManager.ball.linear_velocity = Vector2.ZERO
	GameManager.ball.global_position = get_viewport().get_visible_rect().size * 0.5
	GameManager.ball.show()



func show_game_over(winner: String) -> void:
	winner_label.text = "GAME OVER \n"+ winner + " WINS!"
	restart_hint.text = "Hit 'Space' to restart"
	game_over.show()
	restart_hint.show()
