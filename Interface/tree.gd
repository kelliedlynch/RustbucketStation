@tool
extends ItemList

func _ready() -> void:
	#var base = create_item()
	#hide_root = true
	for i in 6:
		#set_column_title(i, "column " + str(i))
		var item = add_item("item " + str(i))
		for j in 6:
			var nitem = add_item("j item " + str(i) + str(j))
	#set_owners(self)

func set_owners(node: Node):
	for child in node.get_children(true):
		child.owner = self.get_parent()
		set_owners(child)
