extends CharacterBody2D
class_name Bullet

# Nodes
@onready var life_timer: Timer = $LifeTimer

# Var's
@export var speed: float = 650.0
@export var damage: int = 10
@export var life_time: float = 4.0

var direction: Vector2 = Vector2.ZERO
var source: Tank = null

func _ready() -> void:
	set_timers()

func lunch():
	global_rotation = direction.angle()
	velocity = direction * speed
	life_timer.start()

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		global_rotation = velocity.normalized().angle()
		# Bounc SFX

func destroy():
	# Animations (Shader)
	queue_free()

func set_timers():
	life_timer.wait_time = life_time
	life_timer.one_shot = true
	life_timer.connect("timeout", destroy)
