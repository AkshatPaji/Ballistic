extends Node


signal play


signal game_over(player_won: bool)
signal game_started
signal player_scored
signal opponent_scored


signal player_score_changed(score: int)
signal opponent_score_changed(score: int)