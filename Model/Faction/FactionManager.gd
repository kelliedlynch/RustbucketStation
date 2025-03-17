@tool
extends Node

static var Station: Faction = load("uid://bp8l1wo8avjr1")
static var SpaceWizards: Faction = load("uid://gdy230o1m8va")
static var SpaceFascists: Faction = load("uid://cdnhushyoojdf")
static var GrossAliens: Faction = load("uid://ceu3385komw6s")
static var SexyAliens: Faction = load("uid://c6goux6qls0wk")
static var PluckyRebels: Faction = load("uid://b1elkkb1yqgl2")

static var AllFactions: Array[Faction] = [SpaceWizards, PluckyRebels, SpaceFascists, SexyAliens, GrossAliens]

#var Station: Faction = preload("uid://bp8l1wo8avjr1")
#var SpaceWizards: Faction = preload("uid://gdy230o1m8va")
#var SpaceFascists: Faction = preload("uid://cdnhushyoojdf")
#var GrossAliens: Faction = preload("uid://ceu3385komw6s")
#var SexyAliens: Faction = preload("uid://c6goux6qls0wk")
#var PluckyRebels: Faction = preload("uid://b1elkkb1yqgl2")
#
### Note: AllFactions does not include Station faction, as it isn't normally selectable.
#var AllFactions: Array[Faction] = [SpaceWizards, PluckyRebels, SpaceFascists, SexyAliens, GrossAliens]

static var RepMap: Dictionary[Array, int]

static func _static_init() -> void:
	for i in AllFactions.size():
		for j in AllFactions.size():
			if i == j: continue
			if RepMap.has([AllFactions[i], AllFactions[j]]): continue
			RepMap[[AllFactions[i], AllFactions[j]]] = 50
