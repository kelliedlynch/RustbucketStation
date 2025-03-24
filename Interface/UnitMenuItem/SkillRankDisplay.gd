extends MarginContainer
class_name SkillRankDisplay

@export var rank: SkillRank:
	set(value):
		rank = value
		if not is_inside_tree(): await ready
		rank_letter.text = str(value)
		var col = rank_colors[rank]
		rank_letter.add_theme_color_override("font_shadow_color", col)
		var bar_color = Color(col)
		var blend_color = Color.WHITE
		blend_color.a = .7
		var blended = bar_color.blend(blend_color)
		#var grad_tex: GradientTexture1D = progress_bar.material.get_shader_parameter("gradient").duplicate()
		#var gradient = grad_tex.gradient.duplicate()
		#gradient.colors[0] = blended
		#grad_tex.gradient = gradient
		#grad.gradient.colors = PackedColorArray([blended])
		#progress_bar.material.set_shader_parameter("gradient", grad_tex)
		
		
@export var exp: int:
	set(value):
		exp = value
		if not is_inside_tree(): await ready
		var a = SkillRank.max
		var fill_value = 1.0 if rank == SkillRank.max else float(exp) / float(rank.rank_up_exp)
		#progress_bar.material.set_shader_parameter("value", fill_value)
		
@onready var rank_letter: Label = find_child("RankLetter")
#@onready var progress_bar: Panel = find_child("ProgressBar")

static var rank_colors: Dictionary[SkillRank, Color] = {
	SkillRank.A: Color.GOLD,
	SkillRank.B: Color.LIME_GREEN,
	SkillRank.C: Color.DODGER_BLUE,
	SkillRank.D: Color.MEDIUM_PURPLE,
	SkillRank.E: Color.GRAY
}

#func _process(delta: float) -> void:
	#var bar_color = Color(rank_colors[rank])
	#var blend_color = Color.WHITE
	#blend_color.a = .5
	#var blended = bar_color.blend(blend_color)
	#var grad_tex: GradientTexture1D = progress_bar.material.get_shader_parameter("gradient").duplicate()
	#var gradient = grad_tex.gradient.duplicate()
	#gradient.colors[0] = blended
	#grad_tex.gradient = gradient
	##grad.gradient.colors = PackedColorArray([blended])
	#progress_bar.material.set_shader_parameter("gradient", grad_tex)
