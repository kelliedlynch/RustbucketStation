shader_type canvas_item;

uniform vec4 line_color : source_color = vec4(1);
uniform float line_thickness : hint_range(0, 40) = 0.0;
uniform float samples : hint_range(4, 50, 1) = 4;

void vertex() {
	vec2 texture_pixel_size = vec2(1.0) / (vec2(1.0) / TEXTURE_PIXEL_SIZE + vec2(line_thickness * 2.0));
	VERTEX += (UV * 2.0 - 1.0) * TEXTURE_PIXEL_SIZE * line_thickness * line_thickness;
	//VERTEX *= texture_pixel_size / TEXTURE_PIXEL_SIZE;

}

vec2 rotate2d(vec2 vector, float angle){
	return vector * mat2(
				vec2(cos(angle),-sin(angle)),
                vec2(sin(angle),cos(angle)));
}

void fragment() {
    vec2 uv = UV;
	vec2 texture_pixel_size = vec2(1.0) / (vec2(1.0) / TEXTURE_PIXEL_SIZE + vec2(line_thickness * 2.0));
	//uv += texture_pixel_size * line_thickness;

    uv = (uv - texture_pixel_size * line_thickness) * (TEXTURE_PIXEL_SIZE / texture_pixel_size);

    //if (uv != clamp(uv, vec2(0.0), vec2(1.0))) {
        //COLOR.a = 0.0;
    //} else {
        //COLOR = texture(TEXTURE, uv);
    //}


	vec2 AR = vec2(TEXTURE_PIXEL_SIZE.x/TEXTURE_PIXEL_SIZE.y, 1.);

	vec2 rightvec = vec2(TEXTURE_PIXEL_SIZE.x * line_thickness, 0);
	float amax = 0.;

	vec4 col = texture(TEXTURE, uv);
	if (col.a > 0.5) {
		COLOR = col;
	} else{
		for (float i = 0.; i<samples; i++) {
			vec2 samplevec = rotate2d(rightvec, i*TAU/float(samples))*AR;
			vec4 sample = texture(TEXTURE, uv + samplevec);
			//amax += sample.a / samples * 0.75;
			//vec4 sample2 = texture(TEXTURE, uv + samplevec / 2.0);
			//amax += sample2.a / samples * 0.5;
			//vec4 sample3 = texture(TEXTURE, uv + samplevec / 4.0);
			//amax += sample3.a / samples * 0.25;
			amax = max(sample.a, amax);
			//vec4 double_sample = texture(TEXTURE, uv + samplevec * 2.0);
			//amax += double_sample.a * 0.25;

		}
		vec4 outline_color = line_color;
		outline_color.a = amax;
		//if (amax > 0.99) discard;
		if (amax > 0.0) {
			COLOR = mix(line_color - vec4(0.,0.,0.,1.), line_color, amax);
		}
	}


		//COLOR = mix(line_color - vec4(0.,0.,0.,1.), line_color, amax);
		//for (float i = 0.; i < samples; i++) {

			//outline += texture(TEXTURE, uv + vec2(-size.x * mult, size.y * mult * 0.75) * float(i)).a;
			//outline += texture(TEXTURE, uv + vec2(-size.x * mult * 0.75, size.y * mult) * float(i)).a;
			//outline += texture(TEXTURE, uv + vec2(size.x * mult, size.y * mult * 0.75) * float(i)).a;
			//outline += texture(TEXTURE, uv + vec2(size.x * mult * 0.75, size.y * mult) * float(i)).a;
			//outline += texture(TEXTURE, uv + vec2(-size.x * mult, -size.y * mult * 0.75) * float(i)).a;
			//outline += texture(TEXTURE, uv + vec2(-size.x * mult * 0.75, -size.y * mult) * float(i)).a;
			//outline += texture(TEXTURE, uv + vec2(size.x * mult, -size.y * mult * 0.75) * float(i)).a;
			//outline += texture(TEXTURE, uv + vec2(size.x * mult * 0.75, -size.y * mult) * float(i)).a;
		//}


        //outline += texture(TEXTURE, uv + vec2(-size.x * 0.866, size.y * 0.5)).a;
        //outline += texture(TEXTURE, uv + vec2(-size.x * 0.5, size.y * 0.866)).a;
        //outline += texture(TEXTURE, uv + vec2(size.x * 0.866, size.y * 0.5)).a;
        //outline += texture(TEXTURE, uv + vec2(size.x * 0.5, size.y * 0.866)).a;
        //outline += texture(TEXTURE, uv + vec2(-size.x * 0.866, -size.y * 0.5)).a;
        //outline += texture(TEXTURE, uv + vec2(-size.x * 0.5, -size.y * 0.866)).a;
        //outline += texture(TEXTURE, uv + vec2(size.x * 0.866, -size.y * 0.5)).a;
        //outline += texture(TEXTURE, uv + vec2(size.x * 0.5, -size.y * 0.866)).a;
        //outline = min(outline, 1.0);
//
        //vec4 color = texture(TEXTURE, uv);
	//COLOR = vec4(1);
}