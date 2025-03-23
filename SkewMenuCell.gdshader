shader_type canvas_item;

global uniform float menu_cell_skew;
uniform vec2 rect_size;

void vertex() {
	float y_pos = rect_size.y - VERTEX.y;
	VERTEX += vec2(y_pos * tan(menu_cell_skew), 0.0);
}
