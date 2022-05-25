#extension GL_OES_standard_derivatives : enable

precision highp float;

uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;

vec3 white = vec3(1, 1, 1);
vec3 amaranth_pink = vec3(0.945, 0.612, 0.733);
vec3 maya_blue = vec3(0.298, 0.624, 0.886);

vec3 color_for_position (vec2 position) {
	vec3 color = white;
	
	if (sin(position.x + time / 30.0) / 2.0 - position.y + 0.4 < 0.0) {
		color = amaranth_pink;
	} else if (sin(position.x / 5.0 + time / 21.0 + 20.0) / 2.0 - position.y + 0.5 < 0.0) {
		color = maya_blue;
	}

	return color;
}

void main( void ) {
	vec2 position = ( gl_FragCoord.xy / resolution.xy );

/*	float r = 0.0;
	float g = 0.0;
	float b = 0.0;

	for (float x = -10.0; x <= 10.0; x++) {
		for (float y = -5.0; y <= 5.0; y++) {
			vec3 color = color_for_position(
				vec2(
					(x / resolution.x) + position.x, 
					(y / resolution.y) + position.y
				)
			);
			r += color.x;
			g += color.y;
			b += color.z;
		}
	}

        float blur = 11.0 * 21.0;

	r /= blur;
	g /= blur;
	b /= blur;

	gl_FragColor = vec4(vec3(r, g, b), 1.0);
*/
	gl_FragColor = vec4(color_for_position(position), 1.0);
}
