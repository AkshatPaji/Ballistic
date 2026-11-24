extends RigidBody2D

const START_VELOCITY: Vector2 = Vector2(450.0, 0.0)

const MAX_BOUNCE_ANGLE_DEGREES: float = 65.0

var _is_respawning: bool = false

func _ready() -> void:
	GameManager.ball = self


func start() -> void:
	freeze = false
	linear_velocity = START_VELOCITY


func _physics_process(_delta: float) -> void:
	var arena_width: float = get_viewport_rect().size.x
	if _is_respawning:
		return

	if global_position.x < -8.0:
		_respawn(-1.0)
	elif global_position.x > arena_width + 8.0:
		_respawn(1.0)


func _respawn(serve_direction: float) -> void:
	_is_respawning = true
	freeze = true
	linear_velocity = Vector2.ZERO
	hide()
	await get_tree().create_timer(randf_range(1.0, 4.0)).timeout
	global_position = Vector2(624.0 if serve_direction < 0.0 else 16.0, 180)
	show()
	freeze = false
	linear_velocity = Vector2(absf(START_VELOCITY.x) * serve_direction, 0.0)
	_is_respawning = false


func bounce_from_paddle(horizontal_direction: float, paddle_center_y: float, paddle_height: float) -> void:
	var hit_offset: float = clampf((global_position.y - paddle_center_y) / (paddle_height * 0.5), -1.0, 1.0)
	var angle: float = deg_to_rad(hit_offset * MAX_BOUNCE_ANGLE_DEGREES)
	var speed: float = linear_velocity.length()
	linear_velocity = Vector2(cos(angle) * horizontal_direction, sin(angle)) * speed
