#extension GL_OES_standard_derivatives : enable

precision highp float;

uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;

vec3 white = vec3(1, 1, 1);
vec3 amaranth_pink = vec3(0.945, 0.612, 0.733);
vec3 maya_blue = vec3(0.298, 0.624, 0.886);

void main( void ) {

	vec2 position = ( gl_FragCoord.xy / resolution.xy );

	vec3 color = white;
	
	if (sin(position.x + time / 10.0) / 2.0 - position.y + 0.7 < 0.0) {
		color = amaranth_pink;
	} else if (sin(position.x + time / 7.0 + 20.0) / 2.0 - position.y + 0.7 < 0.0) {
		color = maya_blue;
	}

	gl_FragColor = vec4(color, 1.0);

}
