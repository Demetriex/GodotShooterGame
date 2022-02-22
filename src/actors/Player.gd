extends KinematicBody2D

var speed := 150
var velocity := Vector2.ZERO

onready var sprite : Sprite = $Sprite
onready var bow : Node2D = $Bow
onready var animation_player : AnimationPlayer = $AnimationPlayer

signal attack(rotation)


func _physics_process(_delta: float) -> void:
	var direction : Vector2 = get_direction()
	var mouse_position : Vector2 = get_global_mouse_position()
	var mouse_angle = (mouse_position - global_position).angle()

	if Input.is_action_pressed("m1"):
		emit_signal("attack", mouse_angle)

	if direction != Vector2.ZERO:
		animation_player.play("sprint")
	else:
		animation_player.play("idle")

	velocity = direction * speed
	velocity = move_and_slide(velocity)

	flip_sprite(direction)
	bow.rotation = mouse_angle


func flip_sprite(direction: Vector2) -> void:
	if direction.x < 0:
		sprite.scale.x = -1
	elif direction.x > 0:
		sprite.scale.x = 1


func get_direction() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")
