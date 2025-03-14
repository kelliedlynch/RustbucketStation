extends Node

var Station: Faction = load("uid://bp8l1wo8avjr1")
var SpaceWizards: Faction = load("uid://gdy230o1m8va")
var SpaceFascists: Faction = load("uid://cdnhushyoojdf")
var GrossAliens: Faction = load("uid://ceu3385komw6s")
var SexyAliens: Faction = load("uid://c6goux6qls0wk")
var PluckyRebels: Faction = load("uid://b1elkkb1yqgl2")

## Note: AllFactions does not include Station faction, as it isn't normally selectable.
var AllFactions: Array[Faction] = [SpaceWizards, PluckyRebels, SpaceFascists, SexyAliens, GrossAliens]

var RepMap: Dictionary[Array, int]

func _init() -> void:
	for i in AllFactions.size():
		for j in range(i+1, AllFactions.size() - 1):
			RepMap[[AllFactions[i], AllFactions[j]]] = 50
