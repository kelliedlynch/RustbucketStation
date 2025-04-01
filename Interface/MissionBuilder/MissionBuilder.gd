extends Control



@onready var component_selector: Control = find_child("ComponentSelector")

@onready var desc_faction: Label = find_child("DescFactionLabel")
@onready var desc_target: Label = find_child("DescTargetLabel")
@onready var desc_location: Label = find_child("DescLocationLabel")
@onready var desc_objective: Label = find_child("DescObjectiveLabel")
@onready var desc_text: RichTextLabel = find_child("DescText")

@onready var rewards_container: Container = find_child("FactionRewards")
@onready var reward_money: MenuCell = find_child("SpaceBucksLabel")

@onready var eligible_pilots_container: Container = find_child("EligiblePilotsContainer")

@onready var randomize_button: Button = find_child("RandomizeButton")
@onready var post_button: Button = find_child("PostMission")

@onready var requests_container: Container = find_child("IncomingRequestItems")

var mission: Mission

func _ready() -> void:
	build_request_list()
	mission = Mission.new()
	component_selector.component_selected.connect(_on_component_selected)
	component_selector.randomize_components()
	post_button.pressed.connect(_post_mission)

	
func build_request_list():
	for req in MissionManager.incoming_requests:
		var item = load("res://Interface/MissionList/MissionRequestItem.tscn").instantiate()
		item.request = req
		requests_container.add_child(item)
		item.request_selected.connect(_on_request_selected)
		
func _on_request_selected(req: MissionRequest):
	component_selector.select_components_from_request(req)
	
func _post_mission():
	MissionManager.post_mission(mission)
	mission = Mission.new()
	component_selector.randomize_components()
	
func _on_component_selected(index: int, button: OptionButton, prop: StringName):
	var meta = button.get_item_metadata(index)
	mission.set(prop, button.get_item_metadata(index))
	await get_tree().process_frame
	build_description()
	build_rewards()
	build_eligible_pilots_list()

#func clear_popup_options(button: OptionButton):
	#for i in range(button.item_count - 1, -1, -1):
		#button.remove_item(i)
#
#func configure_popup_options(button: OptionButton):
	#var popup = button.get_popup()
	#for i in button.item_count:
		#popup.set_item_as_radio_checkable(i, false)
		

		
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
	desc_text.add_text(mission.objective.build_objective_text())
	desc_text.pop()
	desc_text.add_text(". May the fortune of the stars be with you!")
	

	
func build_rewards():
	for child in rewards_container.get_children():
		child.queue_free()
	var rewards = mission.rep_reward
	rewards_container.columns = FactionManager.AllFactions.size()
	var vals = []
	for faction in FactionManager.AllFactions:
		var header_cell: MenuCell = load("uid://bsgung4h2sac").instantiate()
		header_cell.show_icon = false
		header_cell.text = faction.abbreviation
		rewards_container.add_child(header_cell)
		var val_cell: MenuCell = load("uid://bsgung4h2sac").instantiate()
		val_cell.show_icon = false
		#val_cell.label_settings = load("uid://c07v3i5nocusr")
		if rewards.has(faction):
			val_cell.text = str(rewards[faction])
			if rewards[faction] < 0:
				val_cell.text_variation = BaseTheme.LabelVariation.LabelNegative
			elif rewards[faction] > 0:
				val_cell.text_variation = BaseTheme.LabelVariation.LabelPositive
				#val_cell.label_settings = load("uid://cvjxrvq34s8pc")
		else:
			val_cell.text = ""
		vals.append(val_cell)
	for cell in vals:
		rewards_container.add_child(cell)
	reward_money.text = str(mission.money_reward)
		
func build_eligible_pilots_list():
	var pilots = mission.get_eligible_pilots()
	for child in eligible_pilots_container.get_children():
		child.queue_free()
	for pilot in pilots:
		var item = load("uid://c82oohrayy22y").instantiate()
		item.pilot = pilot
		eligible_pilots_container.add_child(item)
