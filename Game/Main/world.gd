extends Node2D
class_name World

@onready var projectiles_container: Node2D = %ProjectilesContainer

func _ready() -> void:
	for tank in get_tree().get_nodes_in_group("Tanks"):
		(tank as Tank).lunch_bullet.connect(lunch_bullet)

func lunch_bullet(bullet: Bullet):
	projectiles_container.add_child(bullet)
	bullet.lunch()
