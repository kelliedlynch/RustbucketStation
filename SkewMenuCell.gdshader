shader_type canvas_item;

global uniform float menu_cell_skew;
uniform vec2 rect_size;

void vertex() {
	//float y_pos = VERTEX.y / (1.0 / -TEXTURE_PIXEL_SIZE.y);
	//float y_pos = (1.0 - UV.y) * VERTEX.y;
	//float y_pos = 100.0 * TEXTURE_PIXEL_SIZE.y;
	//VERTEX += vec2(y_pos, 0.0);
	//vec2 add_vec = VERTEX / (1.0 / -TEXTURE_PIXEL_SIZE);
	//x_offset = max(x_offset, VERTEX.y * tan(menu_cell_skew));
	float base_offset = rect_size.y * tan(menu_cell_skew) / 2.0;
	float x_offset = VERTEX.y * tan(menu_cell_skew);
	VERTEX -= vec2(x_offset, 0.0);
}

void fragment() {

}