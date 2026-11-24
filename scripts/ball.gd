extends RigidBody2D

const START_VELOCITY: Vector2 = Vector2(-100.0, 0.0)

func _ready() -> void:
    GameManager.ball = self


func start() -> void:
    freeze = false
    linear_velocity = START_VELOCITY