@tool
extends MarginContainer
class_name SkillMenuCell

#@export var icon: Texture2D
@onready var rank_letter: Label = find_child("RankLetter")
@onready var icon_rect: TextureRect = find_child("IconTexture")
@onready var icon_outline: TextureRect = find_child("IconOutline")

@export var icon: Texture2D:
	set(value):
		icon = value
		if not is_inside_tree(): await ready
		icon_rect.texture = value
		notify_property_list_changed()


var skill_rank: SkillRank:
	set(value):
		skill_rank = value
		if not is_inside_tree(): await ready
		rank_letter.text = str(value)
		var col = rank_colors[value]
		rank_letter.add_theme_color_override("font_shadow_color", col)
		
		
static var rank_colors: Dictionary[SkillRank, Color] = {
	SkillRank.A: Color.GOLD,
	SkillRank.B: Color.LIME_GREEN,
	SkillRank.C: Color.DODGER_BLUE,
	SkillRank.D: Color.MEDIUM_PURPLE,
	SkillRank.E: Color.GRAY
}
