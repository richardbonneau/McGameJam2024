shader_type spatial;
render_mode unshaded, cull_disabled;
 
uniform sampler2D dissolve_tex : hint_default_white;
uniform vec4 front_color : source_color;
uniform vec4 back_color : source_color;
 
void fragment()
{
	float a = COLOR.r - texture(dissolve_tex, UV).x;
	ALPHA_SCISSOR_THRESHOLD = 0.01;
	ALPHA = step(0.0, a);
	ALBEDO = mix(back_color.rgb, front_color.rgb, FRONT_FACING ? 1.0 : 0.0);

}