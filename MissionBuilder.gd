extends Control

@onready var faction_origin: OptionButton = find_child("FactionOrigin")
@onready var faction_target: OptionButton = find_child("FactionTarget")
@onready var location: OptionButton = find_child("Location")
@onready var objective: OptionButton = find_child("Objective")

@onready var component_selector_container: MarginContainer = find_child("ComponentSelectorFrame")

@onready var desc_faction: Label = find_child("DescFactionLabel")
@onready var desc_target: Label = find_child("DescTargetLabel")
@onready var desc_location: Label = find_child("DescLocationLabel")
@onready var desc_objective: Label = find_child("DescObjectiveLabel")
@onready var desc_text: RichTextLabel = find_child("DescText")

@onready var rewards_container: Container = find_child("FactionRewards")

@onready var eligible_pilots_container: Container = find_child("EligiblePilotsContainer")

@onready var randomize_button: Button = find_child("RandomizeButton")

var mission: Mission

func _ready() -> void:
	mission = Mission.new()
	#clear_popup_options(faction_origin)
	#clear_popup_options(faction_target)
	#clear_popup_options(location)
	#clear_popup_options(objective)

	populate_component_button(faction_origin, FactionManager.AllFactions)
	populate_component_button(faction_target, FactionManager.AllFactions)
	populate_component_button(location, LocationManager.AllLocations)
	populate_component_button(objective, Objective.AllObjectives)

	faction_origin.item_selected.connect(_on_component_selected.bind(faction_origin, "origin"))
	faction_target.item_selected.connect(_on_component_selected.bind(faction_target, "target"))
	location.item_selected.connect(_on_component_selected.bind(location, "location"))
	objective.item_selected.connect(_on_component_selected.bind(objective, "objective"))
	randomize_button.pressed.connect(randomize_quest)
	randomize_quest()
	
func _on_component_selected(index: int, button: OptionButton, prop: StringName):
	var meta = button.get_item_metadata(index)
	mission.set(prop, button.get_item_metadata(index))
	await get_tree().process_frame
	build_description()
	build_rewards()
	build_eligible_pilots_list()

func clear_popup_options(button: OptionButton):
	for i in range(button.item_count - 1, -1, -1):
		button.remove_item(i)

func configure_popup_options(button: OptionButton):
	var popup = button.get_popup()
	for i in button.item_count:
		popup.set_item_as_radio_checkable(i, false)
		
func populate_component_button(button: OptionButton, components: Array):
	var popup = button.get_popup()
	for i in components.size():
		button.add_item(components[i].name, i)
		button.set_item_metadata(i, components[i])
		popup.set_item_as_radio_checkable(i, false)
		
func build_description(_val = null):
	desc_text.clear()
	desc_text.add_text("The ")
	desc_text.push_color(Color.AQUA)
	desc_text.add_text(mission.origin.name)
	desc_text.pop()
	desc_text.add_text(" need a brave hero to strike at the vile ")
	desc_text.push_color(Color.RED)
	desc_text.add_text(mission.target.name)
	desc_text.pop()
	desc_text.add_text("! You must travel to ")
	desc_text.push_color(Color.ORANGE)
	desc_text.add_text(mission.location.name)
	desc_text.pop()
	desc_text.add_text(" and ")
	desc_text.push_color(Color.DEEP_PINK)
	#var objective_dict = objective.get_item_metadata(objective.selected)
	#var obj_text = objective_dict.objective_text
	#if objective_dict.objective_targets:
		#obj_text += " " + objective_dict.objective_targets.pick_random()
	desc_text.add_text("obj_text")
	desc_text.pop()
	desc_text.add_text(". May the fortune of the stars be with you!")
	
func build_rewards():
	for child in rewards_container.get_children():
		child.queue_free()
	var money = mission.money_reward
	var rep = mission.rep_reward
	var money_label = Label.new()
	money_label.text = str(money) + " Space Dollars"
	rewards_container.add_child(money_label)
	var rep_header = Label.new()
	rep_header.text = "Reputation Gains"
	build_rewards_display()
	#rewards_container.add_child(rep_header)
	#for key in rep:
		#var rep_label = Label.new()
		#var val = rep[key]
		#if val == 0: continue
		#var sign = "+"
		#if val > 0:
			#rep_label.modulate = Color.WEB_GREEN
		#else:
			#sign = "-"
			#rep_label.modulate = Color.RED
		#rep_label.text = "%s: %s%d" % [key.name, sign, abs(val)]
		#rewards_container.add_child(rep_label)
	#pass

func randomize_quest():
	faction_origin.select(randi_range(0, faction_origin.item_count - 2))
	faction_origin.item_selected.emit(faction_origin.selected)
	faction_target.select(randi_range(0, faction_target.item_count - 1))
	faction_target.item_selected.emit(faction_target.selected)
	location.select(randi_range(0, location.item_count - 1))
	location.item_selected.emit(location.selected)
	objective.select(randi_range(0, objective.item_count - 1))
	objective.item_selected.emit(objective.selected)
	
func build_rewards_display():
	for child in rewards_container.get_children():
		child.queue_free()
	var rewards = mission.rep_reward
	rewards_container.columns = FactionManager.AllFactions.size()
	var vals = []
	for faction in FactionManager.AllFactions:
		var header_cell: MenuCell = load("uid://df6rhbbtuffn4").instantiate()
		header_cell.cell_type = MenuCell.CellType.Header
		header_cell.text = faction.abbreviation
		rewards_container.add_child(header_cell)
		var val_cell: MenuCell = load("uid://df6rhbbtuffn4").instantiate()
		if rewards.has(faction):
			val_cell.text = str(rewards[faction])
			val_cell.label_settings = load("uid://c07v3i5nocusr") if rewards[faction] > 0 else load("uid://cvjxrvq34s8pc")
		else:
			val_cell.text = ""
		vals.append(val_cell)
	for cell in vals:
		rewards_container.add_child(cell)
		
func build_eligible_pilots_list():
	var pilots = mission.get_eligible_pilots()
	for child in eligible_pilots_container.get_children():
		child.queue_free()
	for pilot in pilots:
		var item = load("res://UnitMenuItem/UnitNarrowSummary.tscn").instantiate()
		item.character = pilot
		eligible_pilots_container.add_child(item)
