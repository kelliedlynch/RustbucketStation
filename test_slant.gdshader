shader_type canvas_item;
uniform vec2 container_size;
uniform vec2 rect_size;
uniform float slant;
//uniform vec2 offset;
uniform float rotation;
//float total_width = ;
void vertex() {

	if(rotation != 0.0) {

		float rot = -PI / 2.0 + rotation;


		float h = container_size.y / cos(rotation);
		float h1 = h / 2.0 + rect_size.x / 2.0 - container_size.x / 2.0;
		float h2 = h - h1;
		float final_offset_x = h2 * sin(rotation);
		float final_offset_y = h1 * cos(rotation);
		//float final_offset_y = yy + sady;


		VERTEX = vec2(VERTEX.x * cos(rot) - VERTEX.y * sin(rot), VERTEX.y * cos(rot) + VERTEX.x * sin(rot));
		VERTEX += vec2(final_offset_x, final_offset_y);
		//VERTEX += vec2(0, -rect_size.y * tan(rotation));
	}
	// Called for every vertex the material is visible on.
	if(slant != 0.0) {
		float y_pos = rect_size.y - VERTEX.y;
		VERTEX += vec2(y_pos * tan(slant), 0.0);
	}


	//VERTEX += vec2();
	//VERTEX += vec2(VERTEX.y, 0.0);
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
