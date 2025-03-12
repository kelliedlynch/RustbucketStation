@tool
extends Node2D



@onready var menu_items: VBoxContainer = find_child("MenuItems")


func _ready() -> void:
	await ready
	for i in 12:
		var item = load("res://UnitMenuItem/UnitMenuRow.tscn").instantiate()
		item.character = Character.new(randi_range(1, 9))
		menu_items.add_child(item)
