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
	var spacer = Control.new()
	table.add_child(spacer)
	spacer.owner = self
	for i in cols:
		var header = load("res://SlantedTableHeader.tscn").instantiate()
		header.text = facs[i].name
		table.add_child(header)
		header.owner = self
	for i in cols:
		var row_header = Label.new()
		row_header.text = facs[i].name
		table.add_child(row_header)
		row_header.owner = self
		for j in cols:
			var cell = Label.new()
			if i == j:
				cell.text = "0"
			else:
				cell.text = str(FactionManager.RepMap.get([facs[i], facs[j]]))
			cell.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
			table.add_child(cell)
			cell.owner = self
