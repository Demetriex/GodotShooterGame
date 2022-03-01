extends KinematicBody2D

class_name Character

export var speed := 20.0
export var hp := 10.0
export var max_hp := 10.0

var move_direction := Vector2.ZERO
var velocity := Vector2.ZERO


func _physics_process(_delta : float) -> void:
	velocity = move_and_slide(move_direction * speed)

func take_damage(damage : int) -> void:
	hp = clamp(hp - damage, 0.0, max_hp)
