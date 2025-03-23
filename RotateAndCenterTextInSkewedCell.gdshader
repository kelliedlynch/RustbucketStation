shader_type canvas_item;

uniform vec2 container_size;
uniform vec2 rect_size;
global uniform float menu_cell_skew;

void vertex() {
	float big_h = container_size.y / cos(menu_cell_skew);
	float opp = container_size.x * sin(45);
	float center = (big_h / 2.0) - (opp / 2.0);
	float ul_corner = center + rect_size.x / 2.0;
	float final_offset_y = ul_corner * cos(menu_cell_skew);
	float final_offset_x = (big_h - ul_corner) * sin(menu_cell_skew);
	float rot = -PI / 2.0 + menu_cell_skew;
	vec2 cen = rect_size / 2.0;
	//VERTEX += container_size / 2.0 - rect_size / 2.0;
	VERTEX = vec2((VERTEX.x - cen.x) * cos(rot) - (VERTEX.y - cen.y) * sin(rot), (VERTEX.y - cen.y) * cos(rot) + (VERTEX.x - cen.x) * sin(rot));
	VERTEX += cen + vec2(container_size.y / 2.0 * tan(menu_cell_skew), 0);
	//VERTEX += rect_size / 2.0;
	//VERTEX += vec2(final_offset_x, final_offset_y);
}
