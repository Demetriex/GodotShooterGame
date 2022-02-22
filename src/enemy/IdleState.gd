extends "res://addons/fsm/StateMachine.gd".State

class_name IdleState

func _init() -> void:
	process_enabled = false
	input_enabled = false
	leave_state_enabled = false


func _physics_process(_delta: float) -> void:
	state_machine.transition("chase")


func _on_enter_state() -> void:
	target.animation_player.play("idle")
