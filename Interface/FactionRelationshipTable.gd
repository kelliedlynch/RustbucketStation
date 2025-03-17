@tool
extends Control

@onready var table: Container = find_child("GridContainer")


func _ready() -> void:
	draw_table()

func draw_table():
	for child in table.get_children():
		child.queue_free()
	var facs = FactionManager.AllFactions
	var cols = facs.size()
	table.columns = cols + 1
	table.add_child(Control.new())
	for i in cols:
		var header = load("res://SlantedTableHeader.tscn").instantiate()
		header.text = facs[i].name
		table.add_child(header)
	for i in cols:
		var row_header = Label.new()
		row_header.text = facs[i].name
		table.add_child(row_header)
		for j in cols:
			var cell = Label.new()
			if i == j:
				cell.text = "0"
			else:
				cell.text = str(FactionManager.RepMap.get([facs[i], facs[j]]))
			table.add_child(cell)
