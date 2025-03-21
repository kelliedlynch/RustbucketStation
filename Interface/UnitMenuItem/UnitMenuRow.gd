extends MarginContainer
#class_name UnitMenuRow

@onready var title_label: Label = find_child("TitleLabel")
@onready var name_label: Label = find_child("NameLabel")
@onready var charm_label: Control = find_child("Charm")
@onready var combat_label: Control = find_child("Combat")
@onready var pilot_label: Control = find_child("Pilot")
@onready var stealth_label: Control = find_child("Stealth")
@onready var tech_label: Control = find_child("Tech")
@onready var portrait_rect: TextureRect = find_child("PortraitTexture")
@onready var adventure_bar: NeedsBar = find_child("AdventureBar")
@onready var fame_bar: NeedsBar = find_child("FameBar")
@onready var romance_bar: NeedsBar = find_child("RomanceBar")
@onready var vice_bar: NeedsBar = find_child("ViceBar")
@onready var status_label: Control = find_child("StatusLabel")

var pilot: Pilot

func _process(_delta: float) -> void:
	if pilot:
		name_label.text = pilot.name
		charm_label.text = str(pilot.stats.charm)
		combat_label.text = str(pilot.stats.combat)
		pilot_label.text = str(pilot.stats.pilot)
		stealth_label.text = str(pilot.stats.stealth)
		tech_label.text = str(pilot.stats.tech)
		portrait_rect.texture = pilot.portrait
		adventure_bar.value = pilot.needs.adventure
		fame_bar.value = pilot.needs.fame
		romance_bar.value = pilot.needs.romance
		vice_bar.value = pilot.needs.vice
		status_label.text = pilot.status.to_string()
