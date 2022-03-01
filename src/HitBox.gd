extends Area2D

class_name HitBox

onready var collision_shape := $CollisionShape2D
onready var parent := get_parent()


func _init() -> void:
	connect("area_entered", self, "_on_area_entered")

func _ready() -> void:
	assert(collision_shape != null)

func _on_area_entered(area : Area2D):
	parent.sprite.material.set_shader_param("flash_modifier", 1)
	yield(get_tree().create_timer(0.1), "timeout")
	parent.sprite.material.set_shader_param("flash_modifier", 0)
	parent.take_damage(area.damage)
