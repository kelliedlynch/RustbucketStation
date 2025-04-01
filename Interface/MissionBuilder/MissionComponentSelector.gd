extends VBoxContainer

@onready var faction_origin: OptionButton = find_child("FactionOrigin")
@onready var faction_target: OptionButton = find_child("FactionTarget")
@onready var location: OptionButton = find_child("Location")
@onready var objective: OptionButton = find_child("Objective")

signal component_selected

func _ready() -> void:
	var faction_components = []
	for i in FactionManager.AllFactions.size():
		var component = FactionComponent.new()
		component.faction = FactionManager.AllFactions[i]
		faction_components.append(component)
	_populate_component_button(faction_origin, faction_components)
	_populate_component_button(faction_target, faction_components)
	var location_components = []
	for i in LocationManager.AllLocations.size():
		var component = LocationComponent.new()
		component.location = LocationManager.AllLocations[i]
		location_components.append(component)
	_populate_component_button(location, location_components)
	_populate_component_button(objective, Objective.AllObjectives)
	
	faction_origin.item_selected.connect(component_selected.emit.bind(faction_origin, "origin"))
	faction_target.item_selected.connect(component_selected.emit.bind(faction_target, "target"))
	location.item_selected.connect(component_selected.emit.bind(location, "location"))
	objective.item_selected.connect(component_selected.emit.bind(objective, "objective"))
	
func select_components_from_request(request: MissionRequest) -> void:
	if request.origin:
		var index = range(0, faction_origin.item_count).find_custom(func(x): return faction_origin.get_item_metadata(x).faction == request.origin.faction)
		faction_origin.select(index)
		component_selected.emit(index, faction_origin, "origin")
	if request.target:
		var index = range(0, faction_target.item_count).find_custom(func(x): return faction_target.get_item_metadata(x).faction == request.target.faction)
		faction_target.select(index)
		component_selected.emit(index, faction_target, "target")
	if request.location:
		var index = range(0, location.item_count).find_custom(func(x): return location.get_item_metadata(x).location == request.location.location)
		location.select(index)
		component_selected.emit(index, location, "location")
	if request.objective:
		var index = range(0, objective.item_count).find_custom(func(x): return objective.get_item_metadata(x) == request.objective)
		objective.select(index)
		component_selected.emit(index, objective, "objective")

	
func _populate_component_button(button: OptionButton, components: Array):
	var popup = button.get_popup()
	for i in components.size():
		button.add_item(components[i].name, i)
		button.set_item_metadata(i, components[i])
		popup.set_item_as_radio_checkable(i, false)

func randomize_components():
	faction_origin.select(randi_range(0, faction_origin.item_count - 2))
	faction_origin.item_selected.emit(faction_origin.selected)
	faction_target.select(randi_range(0, faction_target.item_count - 1))
	faction_target.item_selected.emit(faction_target.selected)
	location.select(randi_range(0, location.item_count - 1))
	location.item_selected.emit(location.selected)
	objective.select(randi_range(0, objective.item_count - 1))
	objective.item_selected.emit(objective.selected)
