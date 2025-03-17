extends Node

var Station: Faction = preload("uid://bp8l1wo8avjr1")
var SpaceWizards: Faction = preload("uid://gdy230o1m8va")
var SpaceFascists: Faction = preload("uid://cdnhushyoojdf")
var GrossAliens: Faction = preload("uid://ceu3385komw6s")
var SexyAliens: Faction = preload("uid://c6goux6qls0wk")
var PluckyRebels: Faction = preload("uid://b1elkkb1yqgl2")

## Note: AllFactions does not include Station faction, as it isn't normally selectable.
var AllFactions: Array[Faction] = [SpaceWizards, PluckyRebels, SpaceFascists, SexyAliens, GrossAliens]

var RepMap: Dictionary[Array, int]

func _init() -> void:
	for i in AllFactions.size():
		for j in AllFactions.size():
			if i == j: continue
			if RepMap.has([AllFactions[i], AllFactions[j]]): continue
			RepMap[[AllFactions[i], AllFactions[j]]] = 50
