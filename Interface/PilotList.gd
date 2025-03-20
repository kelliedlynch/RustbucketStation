extends Control

@onready var list_items_container: Container = find_child("ListItems")

func _ready() -> void:
	for pilot in PilotManager.all_pilots:
		var item = load("res://UnitMenuItem/UnitMenuRow.tscn").instantiate()
		item.character = pilot
		list_items_container.add_child(item)
