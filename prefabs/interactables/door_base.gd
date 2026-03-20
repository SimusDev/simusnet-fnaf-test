@tool
extends Node3D

@export var _component: CT_Door
@export var _animation_player: AnimationPlayer
@export var _anim_open: StringName
@export var _anim_open_backwards: bool = false
@export var _anim_close: StringName
@export var _anim_close_backwards: bool = false

var _start_sync: bool = false

func _ready() -> void:
	pass

func _try_play_animation(anim: StringName, backwards: bool = false) -> void:
	if is_instance_valid(_animation_player):
		if backwards:
			_animation_player.play_backwards(anim)
		else:
			_animation_player.play(anim)
	
	if !_animation_player.has_animation(anim) or _start_sync:
		return
	
	_animation_player.seek(_animation_player.get_animation(anim).length)
	_start_sync = true

func _on_ct_door_on_status_changed() -> void:
	if _component.status:
		_try_play_animation(_anim_open, _anim_open_backwards)
	else:
		_try_play_animation(_anim_close, _anim_close_backwards)
