extends CharacterBody2D
class_name Tank

# Nodes:
@onready var cannon_pivot: Node2D = $Pivot

# Var's:
@export_group("Movement")
@export var speed: float = 500.0
@export_range(0, 1, 0.01) var acceleration: float = 0.03
@export_range(0, 1, 0.01) var friction: float = 0.15

var direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	movement_handle(delta)
	body_rotation_hanlder(delta)
	cannon_rotation_handler(delta)
	move_and_collide(velocity * delta)

func movement_handle(delta: float):
	direction = Input.get_vector("left", "right", "top", "down")
	if direction:
		velocity = Vector2(
			lerp(velocity.x, direction.x * speed, acceleration),
			lerp(velocity.y, direction.y * speed, acceleration)
		)
	else :
		velocity = Vector2(
			lerp(velocity.x, 0.0, friction),
			lerp(velocity.y, 0.0, friction)
		)

func body_rotation_hanlder(delta: float):
	if direction:
		global_rotation = direction.angle()

func cannon_rotation_handler(delta: float):
	var mouse_pos: Vector2 = get_global_mouse_position()
	cannon_pivot.global_rotation = cannon_pivot.global_position.direction_to(mouse_pos).angle() + PI
