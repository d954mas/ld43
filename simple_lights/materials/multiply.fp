varying vec2 var_texcoord0;

uniform lowp sampler2D tex0;
uniform lowp sampler2D tex1;
uniform lowp vec4 tint0;
uniform lowp vec4 tint1;
uniform lowp vec4 resolution;

//RADIUS of our vignette, where 0.5 results in a circle fitting the screen
const float RADIUS = 0.6;
//softness of our vignette, between 0.0 and 1.0\n" + 
const float SOFTNESS = 0.55;
const vec3 SEPIA = vec3(1.2, 1.0, 0.8);

void main()
{
    // Pre-multiply alpha since all runtime textures already are
    vec4 tint0_pm = vec4(tint0.xyz * tint0.w, tint0.w);
    vec4 tint1_pm = vec4(tint1.xyz * tint1.w, tint1.w);

    vec4 color0 = texture2D(tex0, var_texcoord0.xy) * tint0_pm;
    vec4 color1 = texture2D(tex1, var_texcoord0.xy) * tint1_pm;
	vec4 texColor = color0 * color1;

	//determine center position
	vec2 position = (var_texcoord0.xy - vec2(0.5));
	//determine the vector length of the center position
	float len = length(position); 
	//use smoothstep to create a smooth vignette
	float vignette = smoothstep(RADIUS, RADIUS-SOFTNESS, len);
	//apply our vignette with 50% opacity
	texColor.rgb = mix(texColor.rgb, texColor.rgb * vignette, 0.9);
	//texColor.rgb = mix(texColor.rgb, texColor.rgb * vignette, 0.5);
	//2. GRAYSCALE 
	//convert to grayscale using NTSC conversion weights + 
	//float gray = dot(texColor.rgb, vec3(0.299, 0.587, 0.114));
	//3. SEPIA
	//create our sepia tone from some constant value
	//vec3 sepiaColor = vec3(gray) * SEPIA;
	//again we'll use mix so that the sepia effect is at 75% + 
	//texColor.rgb = mix(texColor.rgb, sepiaColor, 0.75);
	//final colour, multiplied by vertex colour
	
	gl_FragColor = texColor;
	//gl_FragColor = vec4(len,len,len,1);
	//gl_FragColor = vec4( vec3( step(0.5, len) ), 1.0 );
	//determine the vector length of the center position

	//show our length for debugging
	//gl_FragColor = vec4( vec3(len), 1.0 );
}
