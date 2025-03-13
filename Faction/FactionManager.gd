extends Node

var Station: Faction = Faction.StationFaction.new()
var SpaceWizards: Faction = Faction.SpaceWizardsFaction.new()
var FascistEmpire: Faction = Faction.FascistEmpireFaction.new()
var GrossAliens: Faction = Faction.GrossAliensFaction.new()
var SexyAliens: Faction = Faction.SexyAliensFaction.new()
var PluckyRebels: Faction = Faction.PluckyRebelsFaction.new()

var AllFactions = [SpaceWizards, PluckyRebels, FascistEmpire, SexyAliens, GrossAliens, Station]

var RepMap: Dictionary[Array, int]

func _init() -> void:
	for i in AllFactions.size():
		for j in range(i+1, AllFactions.size() - 1):
			RepMap[[AllFactions[i], AllFactions[j]]] = 50
