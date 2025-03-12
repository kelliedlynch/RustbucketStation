@tool
extends MarginContainer
#class_name UnitMenuRow

@onready var title_label: Label = find_child("TitleLabel")
@onready var name_label: Label = find_child("NameLabel")
@onready var charm_label: Label = find_child("CharmLabel")
@onready var combat_label: Label = find_child("CombatLabel")
@onready var pilot_label: Label = find_child("PilotLabel")
@onready var stealth_label: Label = find_child("StealthLabel")
@onready var tech_label: Label = find_child("TechLabel")
@onready var portrait_rect: TextureRect = find_child("PortraitTexture")
@onready var adventure_bar: NeedsBar = find_child("AdventureBar")
@onready var fame_bar: NeedsBar = find_child("FameBar")
@onready var romance_bar: NeedsBar = find_child("RomanceBar")
@onready var vice_bar: NeedsBar = find_child("ViceBar")

var character: Character

func _process(delta: float) -> void:
	if character:
		name_label.text = character.name
		charm_label.text = str(character.stat_charm)
		combat_label.text = str(character.stat_combat)
		pilot_label.text = str(character.stat_pilot)
		stealth_label.text = str(character.stat_stealth)
		tech_label.text = str(character.stat_tech)
		portrait_rect.texture = character.portrait
		adventure_bar.value = character.need_adventure
		fame_bar.value = character.need_fame
		romance_bar.value = character.need_romance
		vice_bar.value = character.need_vice
