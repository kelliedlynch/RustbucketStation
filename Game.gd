extends Node

signal game_tick_advanced
var game_tick: int = 0

func _ready() -> void:
	Player._on_game_begin()
	CharacterManager._on_game_begin()

func advance_game_tick() -> void:
	game_tick += 1
	game_tick_advanced.emit()
