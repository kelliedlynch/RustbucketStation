@tool
extends PanelContainer
class_name CharacterListItem

@onready var name_label: Label = find_child("Name")
@onready var job_label: Label = find_child("Job")
@onready var rank_label: Label = find_child("Rank")
@onready var combat_label: Label = find_child("Combat")
@onready var pilot_label: Label = find_child("Pilot")
@onready var stealth_label: Label = find_child("Stealth")
@onready var charm_label: Label = find_child("Charm")
@onready var tech_label: Label = find_child("Tech")

var character: Character

func _ready() -> void:
	if not character and get_tree().edited_scene_root == self or get_tree().current_scene == self:
		character = Character.new(randi_range(1, 9))
	name_label.text = character.name
	job_label.text = character.job
	rank_label.text = str(character.rank)
	combat_label.text = str(character.stat_combat)
	pilot_label.text = str(character.stat_pilot)
	stealth_label.text = str(character.stat_stealth)
	charm_label.text = str(character.stat_charm)
	tech_label.text = str(character.stat_tech)
