#extension GL_OES_standard_derivatives : enable

precision highp float;

uniform float time;
uniform vec2 resolution;

void main( void ) {

	float t = time / 50.0;
	vec2 position = ( gl_FragCoord.xy / resolution.xy );

	vec3 color = vec3(0, 0, 0);
	
	color.r += sin(t + position.x + position.y);
	color.g += cos(t + position.x - position.y);
	color.b += sin(-t + position.x);

	gl_FragColor = vec4( color, 1.0 );

}
