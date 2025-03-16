extends Node

func _ready() -> void:
	await ready
	
func _on_game_begin() -> void:
	for i in 20:
		CharacterManager.in_station.append(Character.new(randi_range(1, 9)))
