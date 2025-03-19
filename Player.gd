extends Node

var reputation: Dictionary[Faction, int] = {}

func _ready() -> void:
	await ready
	
func _on_game_begin() -> void:
	for i in 20:
		CharacterManager.in_station.append(Character.new(randi_range(1, 9)))
	for fac in FactionManager.AllFactions:
		reputation[fac] = 500
