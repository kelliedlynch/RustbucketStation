extends Control

@onready var list_items: Container = find_child("ListItems")

var refresh_queued: bool = false

func _ready() -> void:
	#visibility_changed.connect(refresh_list)
	Game.game_tick_advanced.connect(queue_refresh.unbind(1))
	MissionManager.mission_updated.connect(queue_refresh.unbind(1))
	refresh_list()
	
func queue_refresh() -> void:
	refresh_queued = true
	
func refresh_list():
	if not visible: return
	for child in list_items.get_children():
		child.queue_free()
	for mission: Mission in MissionManager.all_missions:
		var item = load("res://Interface/MissionList/MissionListItem.tscn").instantiate()
		item.mission = mission
		#if not mission.crew.is_empty():
			#item.pilot = mission.crew[0]
		list_items.add_child(item)

func _process(delta: float) -> void:
	if refresh_queued:
		refresh_queued = false
		refresh_list()
		
