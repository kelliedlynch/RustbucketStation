extends Control

@onready var faction_origin: OptionButton = find_child("FactionOrigin")
@onready var faction_target: OptionButton = find_child("FactionTarget")
@onready var location: OptionButton = find_child("Location")
@onready var objective: OptionButton = find_child("Objective")

@onready var desc_faction: Label = find_child("DescFactionLabel")
@onready var desc_target: Label = find_child("DescTargetLabel")
@onready var desc_location: Label = find_child("DescLocationLabel")
@onready var desc_objective: Label = find_child("DescObjectiveLabel")
@onready var desc_text: RichTextLabel = find_child("DescText")

@onready var randomize_button: Button = find_child("RandomizeButton")

func _ready() -> void:
	clear_popup_options(faction_origin)
	clear_popup_options(faction_target)
	clear_popup_options(location)
	clear_popup_options(objective)
	for faction in FactionManager.AllFactions:
		faction_origin.add_item(faction.name)
		if not faction is Faction.StationFaction: 
			faction_target.add_item(faction.name)
	configure_popup_options(faction_origin)
	configure_popup_options(faction_target)
	
	for loc in Location.AllLocations:
		location.add_item(loc.name)
	configure_popup_options(location)
	
	for i in Objective.AllObjectives.size():
		objective.add_item(Objective.AllObjectives[i].name)
		objective.set_item_metadata(i, Objective.AllObjectives[i])
		
	configure_popup_options(objective)
	faction_origin.item_selected.connect(build_description)
	faction_target.item_selected.connect(build_description)
	location.item_selected.connect(build_description)
	objective.item_selected.connect(build_description)
	randomize_button.pressed.connect(randomize_quest)
	randomize_quest()

func clear_popup_options(button: OptionButton):
	for i in range(button.item_count - 1, -1, -1):
		button.remove_item(i)

func configure_popup_options(button: OptionButton):
	var popup = button.get_popup()
	for i in button.item_count:
		popup.set_item_as_radio_checkable(i, false)
		
func build_description(_val = null):
	desc_text.clear()
	desc_text.add_text("The ")
	desc_text.push_color(Color.AQUA)
	desc_text.add_text(faction_origin.text)
	desc_text.pop()
	desc_text.add_text(" need a brave hero to strike at the vile ")
	desc_text.push_color(Color.RED)
	desc_text.add_text(faction_target.text)
	desc_text.pop()
	desc_text.add_text("! You must travel to ")
	desc_text.push_color(Color.ORANGE)
	desc_text.add_text(location.text)
	desc_text.pop()
	desc_text.add_text(" and ")
	desc_text.push_color(Color.DEEP_PINK)
	var objective_dict = objective.get_item_metadata(objective.selected)
	var obj_text = objective_dict.objective_text
	if objective_dict.objective_targets:
		obj_text += " " + objective_dict.objective_targets.pick_random()
	desc_text.add_text(obj_text)
	desc_text.pop()
	desc_text.add_text(". May the fortune of the stars be with you!")

func randomize_quest():
	faction_origin.select(randi_range(0, faction_origin.item_count - 2))
	faction_target.select(randi_range(0, faction_target.item_count - 1))
	location.select(randi_range(0, location.item_count - 1))
	objective.select(randi_range(0, objective.item_count - 1))
	build_description()
