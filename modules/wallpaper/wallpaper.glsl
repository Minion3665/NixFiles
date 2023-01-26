uniform float time;
uniform vec2 resolution;

vec3 amaranthPink = vec3(241.0, 156.0, 187.0);
vec3 mayaBlue = vec3(115.0, 194.0, 251.0);

void main( void ) {

	float t = time / 50.0;
	vec2 position = ( gl_FragCoord.xy / resolution.xy );

  vec3 color = vec3(0.0, 0.0, 0.0);

	color += ((sin(t + position.y) + 1.0) * amaranthPink) / 255.0 / 2.0;
	color += ((sin(-t + position.x) + 1.0) * mayaBlue) / 255.0 / 2.0;
	
	/* color.r += sin(t + position.x + position.y) * amaranthPink.r / 255.0; */
	/* color.g += cos(t + position.x - position.y) * amaranthPink.g / 255.0; */
	/* color.b += sin(-t + position.x) * amaranthPink.b / 255.0; */

	gl_FragColor = vec4( color / 0.8, 1.0 );

}
