extends CharacterBody2D

@onready var velocity_component: Node = $VelocityComponent

var _ai_range: float = 320.0


func _ready() -> void:
	$DeflectArea2D.body_entered.connect(_on_deflect_area_body_entered)


func _physics_process(_delta: float) -> void:
	if not is_instance_valid(GameManager.ball):
		velocity_component.stop(self)
		return

	if GameManager.ball.global_position.x > _ai_range && GameManager.ball.global_position.x < global_position.x && GameManager.ball.linear_velocity.x > 0:
		var ball_y: float = GameManager.ball.global_position.y
		var direction: Vector2 = Vector2.ZERO

		if ball_y < global_position.y:
			direction.y = -1.0
		else:
			direction.y = 1.0

		velocity_component.move(self, direction)

	else:
		velocity_component.stop(self)

	var paddle_shape: RectangleShape2D = $CollisionShape2D.shape
	var half_height: float = paddle_shape.size.y * 0.5
	global_position.y = clampf(global_position.y, half_height, 360.0 - half_height)


func _on_deflect_area_body_entered(body: Node2D) -> void:
	if body.has_method("bounce_from_paddle"):
		var paddle_shape: RectangleShape2D = $CollisionShape2D.shape
		body.bounce_from_paddle(-1.0, global_position.y, paddle_shape.size.y)

