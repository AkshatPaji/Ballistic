extends RigidBody2D

const START_VELOCITY: Vector2 = Vector2(300.0, 0.0)

const MAX_BOUNCE_ANGLE_DEGREES: float = 65.0

func _ready() -> void:
	GameManager.ball = self


func start() -> void:
	freeze = false
	linear_velocity = START_VELOCITY


func bounce_from_paddle(horizontal_direction: float, paddle_center_y: float, paddle_height: float) -> void:
	var hit_offset: float = clampf((global_position.y - paddle_center_y) / (paddle_height * 0.5), -1.0, 1.0)
	var angle: float = deg_to_rad(hit_offset * MAX_BOUNCE_ANGLE_DEGREES)
	var speed: float = linear_velocity.length()
	linear_velocity = Vector2(cos(angle) * horizontal_direction, sin(angle)) * speed
