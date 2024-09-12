#version 440


layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(binding = 1) uniform sampler2D colorTable;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
};

void main()
{
    fragColor = texture(colorTable, qt_TexCoord0);
    fragColor.w *= qt_Opacity;
} 

