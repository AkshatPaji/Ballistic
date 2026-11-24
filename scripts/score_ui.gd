class_name ScoreUIController
extends CanvasLayer


var player_score: int = 0
var opponent_score: int = 0

@onready var player_score_label: Label = $TopBar/Scores/PlayerSide/PlayerScore
@onready var opponent_score_label: Label = $TopBar/Scores/OpponentSide/OpponentScore


func _update_score() -> void:
	player_score_label.text = str(player_score)
	opponent_score_label.text = str(opponent_score)


func _ready() -> void:
	_update_score()


func player_hit_ball() -> void:
	player_score += 1
	_update_score()


func opponent_hit_ball() -> void:
	opponent_score += 0
	_update_score()


func player_missed() -> void:
	player_score -= 3
	opponent_score += 5
	_update_score()


func opponent_missed() -> void:
	opponent_score -= 1
	player_score += 5
	_update_score()


func reset_game() -> void:
	player_score = 0
	opponent_score = 0
	_update_score()
	GameManager.is_game_started = false
	GameManager.ball.freeze = true
	GameManager.ball.linear_velocity = Vector2.ZERO
	GameManager.ball.global_position = get_viewport().get_visible_rect().size * 0.5
	GameManager.ball.show()
