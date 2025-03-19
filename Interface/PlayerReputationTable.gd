extends Control

@onready var table_container: Container = find_child("TableContainer")

func _ready() -> void:
	build_table()

func build_table():
	for child in table_container.get_children():
		child.queue_free()
	for fac in FactionManager.AllFactions:
		var name_label = Label.new()
		name_label.text = fac.name
		table_container.add_child(name_label)
		var val_label = Label.new()
		val_label.text = str(Player.reputation[fac])
		table_container.add_child(val_label)
