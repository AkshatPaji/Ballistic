extends RigidBody2D

@onready var score_ui: ScoreUIController = get_node("../../ScoreUI")

const START_VELOCITY: Vector2 = Vector2(450.0, 0.0)
const MAX_BOUNCE_ANGLE_DEGREES: float = 65.0

var _is_respawning: bool = false
var _reset_game_pending: bool = false

func _ready() -> void:
	GameManager.ball = self


func start() -> void:
	if _reset_game_pending:
		score_ui.reset_game()
		_reset_game_pending = false

	_is_respawning = false
	freeze = false
	linear_velocity = START_VELOCITY


func _physics_process(_delta: float) -> void:
	if _is_respawning:
		return

	var arena_width: float = get_viewport_rect().size.x

	if global_position.x < -8.0:
		_is_respawning = true
		score_ui.player_missed()
		if score_ui.player_score < 0 or score_ui.opponent_score < 0:
			_reset_game_pending = true
			_reset_ball_to_center()
		else:
			_respawn(-1.0)
	elif global_position.x > arena_width + 8.0:
		_is_respawning = true
		score_ui.opponent_missed()
		if score_ui.player_score < 0 or score_ui.opponent_score < 0:
			_reset_game_pending = true
			_reset_ball_to_center()
		else:
			_respawn(1.0)


func _reset_ball_to_center() -> void:
	freeze = true
	linear_velocity = Vector2.ZERO
	global_position = get_viewport().get_visible_rect().size * 0.5
	show()
	GameManager.is_game_started = false


func _respawn(serve_direction: float) -> void:
	_is_respawning = true
	freeze = true
	linear_velocity = Vector2.ZERO
	hide()
	await get_tree().create_timer(randf_range(1.0, 4.0)).timeout

	var arena_size: Vector2 = get_viewport_rect().size
	var spawn_x: float = arena_size.x - 8.0 if serve_direction < 0.0 else 8.0
	var spawn_y: float = 8.0 if randf() < 0.5 else arena_size.y - 8.0
	global_position = Vector2(spawn_x, spawn_y)
	show()
	freeze = false
	var angle: float = deg_to_rad(randf_range(-60.0, 60.0))
	var speed: float = absf(START_VELOCITY.x)
	linear_velocity = Vector2(cos(angle) * serve_direction, sin(angle)) * speed
	_is_respawning = false


func bounce_from_paddle(horizontal_direction: float, paddle_center_y: float, paddle_height: float) -> void:
	var hit_offset: float = clampf((global_position.y - paddle_center_y) / (paddle_height * 0.5), -1.0, 1.0)
	var angle: float = deg_to_rad(hit_offset * MAX_BOUNCE_ANGLE_DEGREES)
	var speed: float = linear_velocity.length()
	linear_velocity = Vector2(cos(angle) * horizontal_direction, sin(angle)) * speed
