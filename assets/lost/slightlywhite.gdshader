shader_type canvas_item;

uniform vec4 target_color : source_color = vec4(1.0, 1.0, 1.0, 0.5); 
uniform float tolerance : hint_range(0.0, 1.0) = 0.05;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    
    float color_diff = distance(tex_color, target_color);
    
    if (color_diff < tolerance) {
        COLOR = vec4(0.0);
    } else {
        COLOR = tex_color;
    }
}