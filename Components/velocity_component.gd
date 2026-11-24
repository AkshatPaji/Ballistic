extends Node

@export var max_speed: float = 200.0
@export var acceleration: float = 25.0

var _velocity: Vector2 = Vector2.ZERO


func move(character_body: CharacterBody2D, direction: Vector2) -> void:
    _accelerate_in_direction(direction)
    character_body.velocity = _velocity
    character_body.move_and_slide()
    _velocity = character_body.velocity


func stop(character_body: CharacterBody2D) -> void:
    _accelerate_in_direction(Vector2.ZERO)
    character_body.velocity = _velocity
    character_body.move_and_slide()
    _velocity = character_body.velocity


func _accelerate_in_direction(direction: Vector2) -> void:
    var final_velocity: Vector2 = direction * max_speed
    _velocity = _velocity.lerp(final_velocity, 1 - exp(-acceleration * get_process_delta_time()))
