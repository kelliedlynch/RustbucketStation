extends Control

@onready var list_container: Container = find_child("ListContainer")

func _ready() -> void:
	visibility_changed.connect(refresh_list)
	refresh_list()
	
func refresh_list():
	if not visible: return
	for child in list_container.get_children():
		child.queue_free()
	for mission: Mission in MissionManager.all_missions:
		var hbox = HBoxContainer.new()
		var mission_deets = Label.new()
		mission_deets.text = mission.origin.name + "->" + mission.target.name + " @:" + mission.location.name + "Do:" + mission.objective.name
		hbox.add_child(mission_deets)
		for character in mission.crew:
			var char_menu_item = load("res://UnitMenuItem/UnitNarrowSummary.tscn").instantiate()
			char_menu_item.character = character
			hbox.add_child(char_menu_item)
		list_container.add_child(hbox)
