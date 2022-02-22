extends Character

var path : PoolVector2Array = []
onready var level_navigation : Navigation2D = get_tree().current_scene.get_node("Navigation2D")
onready var player : KinematicBody2D = get_tree().current_scene.get_node("Player")

onready var sprite := $Sprite
onready var animation_player := $AnimationPlayer
onready var line_2d = $Line2D

const IdleState = preload("IdleState.gd") 
const ChaseState = preload("ChaseState.gd") 

var state_machine : StateMachine
var smf = StateMachineFactory.new()


func _ready() -> void:
	state_machine = smf.create({
		"target": self,
		"current_state": "idle",
		"states": [
			{"id": "idle", "state": IdleState},
			{"id": "chase", "state": ChaseState},
		],
		"transitions": [
			{"state_id": "idle", "to_states": ["chase", "attack"]},
			{"state_id": "chase", "to_states": ["idle", "attack"]},
		]
	})


func _physics_process(_delta: float) -> void:
	line_2d.global_position = Vector2.ZERO
	if level_navigation and player:
		generate_path()
	
	state_machine._physics_process(_delta)

	._physics_process(_delta)


func generate_path() -> void:
	path = level_navigation.get_simple_path(global_position, player.global_position, false)
	line_2d.points = path

func get_direction() -> void:
	var return_value : Vector2 = Vector2.ZERO

	if path.size() > 0:
		return_value = global_position.direction_to(path[1])

		if global_position == path[0]:
			path.remove(0)

	move_direction = return_value

func flip_sprite() -> void:
	if move_direction.x > 0 and sprite.flip_h:
		sprite.flip_h = false
	elif move_direction.x < 0 and not sprite.flip_h:
		sprite.flip_h = true
