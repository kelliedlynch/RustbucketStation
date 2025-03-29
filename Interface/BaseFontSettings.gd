extends LabelSettings

enum FontVariant {
	NORMAL,
	POSITIVE,
	NEGATIVE
}
@export var variant: FontVariant = FontVariant.NORMAL:
	set(value):
		variant = value
		match value:
			FontVariant.NORMAL:
				pass
		pass

@export_group("Font Colors")
@export var normal: Color = Color.WHITE
@export var positive: Color = Color.LIME_GREEN
@export var negative: Color = Color.RED
