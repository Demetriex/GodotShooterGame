extends Node2D

export (PackedScene) var arrow = preload("res://src/weapon/Arrow.tscn")
onready var arrow_spawn_point := $ArrowSpawnPoint
onready var attack_timer := $AttackTimer


func _on_Player_attack(_rotation : float) -> void:
	if attack_timer.is_stopped():
		$AnimationPlayer.play("shoot")
		var _arrow = arrow.instance()
		_arrow.rotation = _rotation
		_arrow.global_position = arrow_spawn_point.global_position
		get_tree().current_scene.add_child(_arrow)
		attack_timer.start()
