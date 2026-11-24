extends CharacterBody2D

const START_POSITION: Vector2 = Vector2(624.0, 180.0)

@onready var velocity_component: Node = $VelocityComponent

var _ai_range: float = 376.0


func _ready() -> void:
	pass


func _physics_process(_delta: float) -> void:
	if GameManager.ball.global_position.x > _ai_range && GameManager.ball.linear_velocity.x > 0:
		var ball_y: float = GameManager.ball.global_position.y
		var direction: Vector2 = Vector2.ZERO

		if ball_y < global_position.y:
			direction.y = -1.0
		else:
			direction.y = 1.0

		
		velocity_component.move(self, direction)

	else:
		velocity_component.stop(self)
