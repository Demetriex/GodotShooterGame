extends Area2D

export var speed := 500
var direction: Vector2

onready var animation_player := $AnimationPlayer

func _enter_tree() -> void:
	direction = Vector2.RIGHT.rotated(rotation)


func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func delete() -> void:
	queue_free()


func _on_Arrow_body_entered(body: Node) -> void:
	if body.is_in_group("world"):
		animation_player.play("fade_out")
