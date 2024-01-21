shader_type spatial;
render_mode cull_disabled;

uniform vec3 color: source_color;
uniform vec3 color2: source_color;

uniform sampler2D noise;
uniform float noiseScale = 20.0;

//ForWindStatic
//uniform float bendAmount = 0.5;
//uniform float bendSpeed = 1.0;

uniform vec3 player_pos;
uniform float bendRadius = 5.0;


varying vec3 worldPos;
 
void vertex(){
	worldPos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	VERTEX - player_pos; 
//float noiseValue = texture(noise, worldPos.xz / noiseScale).r;
//float bendFactor = sin(TIME * bendSpeed + worldPos.x * 0.1 + worldPos.z * 0.1) * noiseValue * bendAmount;
//VERTEX.y += bendFactor * (1.0 - UV.y);
}

void fragment(){
	vec3 noiselevel = texture(noise, 	worldPos.xz / noiseScale).rgb;
	ALBEDO = mix(color, color2, UV.y) * mix(color, color2, noiselevel.r);
	if(!FRONT_FACING){
		NORMAL= -NORMAL;
	}
}