extends CharacterBody2D
class_name Tank

signal lunch_bullet(bullet: Bullet)

const BULLET = preload("uid://c1vuc4msgcx7f")

# Nodes:
@onready var cannon_pivot: Node2D = $Pivot
@onready var cannon_muzzle: Marker2D = $Pivot/Muzzle

# Var's:
@export_group("Movement")
@export var speed: float = 500.0
@export_range(0, 1, 0.01) var acceleration: float = 0.03
@export_range(0, 1, 0.01) var friction: float = 0.15

var direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	movement_handle()
	body_rotation_hanlder()
	cannon_rotation_handler()
	shooting_hanlder()
	move_and_collide(velocity * delta)

func movement_handle():
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

func body_rotation_hanlder():
	if direction:
		global_rotation = direction.angle()

func cannon_rotation_handler():
	var mouse_pos: Vector2 = get_global_mouse_position()
	cannon_pivot.global_rotation = cannon_pivot.global_position.direction_to(mouse_pos).angle() + PI

func shooting_hanlder():
	if Input.is_action_just_pressed("shoot"):
		var bullet: Bullet = BULLET.instantiate()
		bullet.direction = cannon_muzzle.global_position.direction_to(get_global_mouse_position())
		bullet.global_position = cannon_muzzle.global_position
		bullet.source = self
		lunch_bullet.emit(bullet)
