shader_type canvas_item;
render_mode unshaded;

uniform vec4 colour : hint_color;

void fragment()
{
	COLOR = texture(TEXTURE, UV) * colour;
}