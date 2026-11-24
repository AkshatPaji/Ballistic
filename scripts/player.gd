extends CharacterBody2D

@onready var velocity_component: Node = $VelocityComponent
@onready var score_ui: ScoreUIController = get_node("../../ScoreUI")

func _ready() -> void:
	$DeflectArea2D.body_entered.connect(_on_deflect_area_body_entered)


func _physics_process(_delta: float) -> void:
	velocity_component.move(self, _get_direction())

	# Keep the paddle fully inside the playfield.
	var paddle_shape: RectangleShape2D = $CollisionShape2D.shape
	var half_height: float = paddle_shape.size.y * 0.5
	global_position.y = clampf(global_position.y, half_height, 360.0 - half_height)


func _get_direction() -> Vector2:
	var y_movement: float = Input.get_axis("move_up", "move_down")
	return Vector2(0, y_movement).normalized()


func _on_deflect_area_body_entered(body: Node2D) -> void:
	if body.has_method("bounce_from_paddle"):
		var paddle_shape: RectangleShape2D = $CollisionShape2D.shape
		body.bounce_from_paddle(1.0, global_position.y, paddle_shape.size.y)
		score_ui.player_hit_ball()
