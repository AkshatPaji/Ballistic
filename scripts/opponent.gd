extends CharacterBody2D

@onready var velocity_component: Node = $VelocityComponent

var _ai_range: float = 430.0


func _ready() -> void:
	$DeflectArea2D.body_entered.connect(_on_deflect_area_body_entered)

var _tracking_offset: float = 0.0
var _was_tracking: bool = false


func _physics_process(_delta: float) -> void:
	if not is_instance_valid(GameManager.ball):
		velocity_component.stop(self)
		return

	if GameManager.ball.global_position.x > _ai_range && GameManager.ball.global_position.x < global_position.x && GameManager.ball.linear_velocity.x > 0:
		var time_to_paddle: float = (global_position.x - 16.0 - GameManager.ball.global_position.x) / GameManager.ball.linear_velocity.x
		var target_y: float = GameManager.ball.global_position.y + GameManager.ball.linear_velocity.y * time_to_paddle
		while target_y < 8.0 || target_y > 352.0:
			if target_y < 8.0:
				target_y = 16.0 - target_y
			else:
				target_y = 704.0 - target_y

		if not _was_tracking:
			_tracking_offset = randf_range(-18.0, 18.0)
			_was_tracking = true

		target_y += _tracking_offset

		var direction: Vector2 = Vector2.ZERO

		if target_y < global_position.y - 4.0:
			direction.y = -1.0
		elif target_y > global_position.y + 4.0:
			direction.y = 1.0

		velocity_component.move(self, direction)

	else:
		_was_tracking = false
		velocity_component.stop(self)

	var paddle_shape: RectangleShape2D = $CollisionShape2D.shape
	var half_height: float = paddle_shape.size.y * 0.5
	global_position.y = clampf(global_position.y, half_height, 360.0 - half_height)


func _on_deflect_area_body_entered(body: Node2D) -> void:
	if body.has_method("bounce_from_paddle"):
		var paddle_shape: RectangleShape2D = $CollisionShape2D.shape
		body.bounce_from_paddle(-1.0, global_position.y, paddle_shape.size.y)

