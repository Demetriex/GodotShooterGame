extends KinematicBody2D

class_name Character

export var speed := 20

var move_direction := Vector2.ZERO
var velocity := Vector2.ZERO


func _physics_process(_delta: float) -> void:
	velocity = move_and_slide(move_direction * speed)
