extends Sprite2D

func _ready() -> void:
	await get_tree().create_timer(4).timeout
	create_tween().tween_property(self, "modulate:a", 0.0, 1.0)
