extends Control

@onready var list_items_container: Container = find_child("ListItems")

func _ready() -> void:
	for pilot in PilotManager.all_pilots:
		var item = load("uid://c82oohrayy22y").instantiate()
		item.pilot = pilot
		list_items_container.add_child(item)
