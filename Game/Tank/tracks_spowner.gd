extends Node2D

const TRACKS = preload("uid://cyrpfu7eiu34f")

@onready var delay_timer: Timer = $DelayTimer

@export var delay_time: float = 0.03

func _ready() -> void:
	delay_timer.wait_time = delay_time
	delay_timer.one_shot = true

func _process(delta: float) -> void:
	if owner.velocity and delay_timer.is_stopped():
		var track: Sprite2D = TRACKS.instantiate()
		track.global_position = owner.global_position
		track.global_rotation = owner.direction.angle() + PI/2
		owner.get_parent().get_node("Traks").add_child(track)
		delay_timer.start()
