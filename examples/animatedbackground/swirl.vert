#version 440


layout(location = 0) in vec4 qt_Vertex;
layout(location = 1) in vec2 qt_MultiTexCoord0; 
layout(location = 0) out vec2 qt_TexCoord0;
 
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float tx;
    float ty;
    float tz;
    float tw;
    float amplitude;
    vec4 d;
};

void main() {
	highp vec4 pos = qt_Vertex;

	highp float y1 = sin(tx + d.x * qt_MultiTexCoord0.x * 17. + 2. * d.y) + sin(ty + d.z * qt_MultiTexCoord0.x * 11. + 5. * d.w);
	highp float y2 = sin(tz + d.w * qt_MultiTexCoord0.x * 7. + 3. * d.z) + sin(tw + d.y * qt_MultiTexCoord0.x * 19. + 3. * d.x);

	pos.y += mix(y1, y2, qt_MultiTexCoord0.y) * amplitude * 0.5;

	gl_Position = qt_Matrix * pos;
	qt_TexCoord0 = qt_MultiTexCoord0;
}

