extends Node

var money: int = 100
var reputation: Dictionary[Faction, int] = {}

func _ready() -> void:
	await ready
	
func _on_game_begin() -> void:
	for i in 20:
		PilotManager.create_pilot()
	for fac in FactionManager.AllFactions:
		reputation[fac] = 500
