@tool
extends Control
class_name CharacterList

@onready var list_items: Container = find_child("ListItems")

func _ready() -> void:
	for i in 12:
		var item = load("res://CharacterListItem.tscn").instantiate()
		item.character = Character.new(randi_range(1, 9))
		list_items.add_child(item)
