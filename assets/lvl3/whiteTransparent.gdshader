shader_type canvas_item;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    
    // Check if pixel is white (with a tiny threshold for compressed images)
    if (tex_color.r > 0.99 && tex_color.g > 0.99 && tex_color.b > 0.99) {
        COLOR = vec4(0.0); // Make transparent
    } else {
        COLOR = tex_color; // Keep original
    }
}
