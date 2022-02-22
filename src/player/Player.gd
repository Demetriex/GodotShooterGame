extends Character

onready var bow : Node2D = $Bow
onready var animation_player : AnimationPlayer = $AnimationPlayer
onready var sprite : Sprite = $Sprite

signal attack(rotation)


func _physics_process(_delta: float) -> void:
	var mouse_position : Vector2 = get_global_mouse_position()
	var mouse_angle = (mouse_position - global_position).angle()

	bow.rotation = mouse_angle
	flip_sprite(mouse_position)

	if Input.is_action_pressed("m1"):
		emit_signal("attack", mouse_angle)

	get_direction()

	if move_direction != Vector2.ZERO:
		animation_player.play("sprint")
	else:
		animation_player.play("idle")

	._physics_process(_delta)


func flip_sprite(mouse_position: Vector2) -> void:
	var mouse_direction = (mouse_position - global_position).normalized()

	if mouse_direction.x > 0 and sprite.flip_h:
		sprite.flip_h = false
	elif mouse_direction.x < 0 and not sprite.flip_h:
		sprite.flip_h = true


func get_direction() -> void:
	move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
