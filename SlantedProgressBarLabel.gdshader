shader_type canvas_item;

uniform vec2 rect_size;
//float total_width = ;
void vertex() {
	VERTEX += vec2(VERTEX.y * cos(PI / 2.0) + VERTEX.y * sin(PI / 2.0), VERTEX.x * cos(PI / 2.0) - VERTEX.x * sin(PI / 2.0));
	//VERTEX += rect_size / 2.0;
	//float y_pos = rect_size.y - VERTEX.y;
	//VERTEX -= vec2(y_pos * 0.8, 0.0);
	//VERTEX += vec2(VERTEX.y, 0.0);
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
