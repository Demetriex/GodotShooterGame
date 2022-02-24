extends Area2D

class_name HitBox

onready var collision_shape : CollisionShape2D = get_child(0)
onready var parent := get_parent()


func _init() -> void:
	connect("area_entered", self, "_on_area_entered")

func _ready() -> void:
	assert(collision_shape != null)

func _on_area_entered(area : Area2D):
	parent.take_damage(area.damage)
