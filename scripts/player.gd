extends CharacterBody2D

const START_POSITION: Vector2 = Vector2(16.0, 180.0)

@onready var velocity_component: Node = $VelocityComponent

func _ready() -> void:
	pass


func _physics_process(_delta: float) -> void:
	velocity_component.move(self, _get_direction())

	# Keep the paddle fully inside the playfield.
	var paddle_shape: RectangleShape2D = $CollisionShape2D.shape
	var half_height: float = paddle_shape.size.y * 0.5
	global_position.y = clampf(global_position.y, half_height, 360.0 - half_height)


func _get_direction() -> Vector2:
	var y_movement: float = Input.get_axis("move_up", "move_down")
	return Vector2(0, y_movement).normalized()
