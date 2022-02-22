extends KinematicBody2D

export var speed := 20
var velocity := Vector2.ZERO

var path : PoolVector2Array = []
onready var level_navigation : Navigation2D = get_tree().current_scene.get_node("Navigation2D")
onready var player : KinematicBody2D = get_tree().current_scene.get_node("Player")

onready var sprite := $Sprite
onready var animation_player := $AnimationPlayer
onready var line_2d = $Line2D

func _physics_process(_delta: float) -> void:
	line_2d.global_position = Vector2.ZERO

	if level_navigation and player:
		generate_path()

	var direction = get_direction()

	if direction != Vector2.ZERO:
		animation_player.play("sprint")
	else:
		animation_player.play("idle")

	flip(direction)

	velocity = move_and_slide(direction * speed)

func generate_path() -> void:
	path = level_navigation.get_simple_path(global_position, player.global_position, false)
	line_2d.points = path

func get_direction() -> Vector2:
	var return_value : Vector2 = Vector2.ZERO

	if path.size() > 0:
		return_value = global_position.direction_to(path[1])
		
		if global_position == path[0]:
			path.remove(0)

	return return_value

func flip(direction: Vector2) -> void:
	if direction.x < 0:
		sprite.scale.x = -1
	elif direction.x > 0:
		sprite.scale.x = 1
