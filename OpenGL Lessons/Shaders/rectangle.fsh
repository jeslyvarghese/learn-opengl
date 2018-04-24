#version 330 core
out vec4 fragColor;
in vec4 vertexColor;
in vec2 texCoords;
uniform sampler2D texture0;
uniform sampler2D texture1;
void main() {
    fragColor = mix(texture(texture0, texCoords), texture(texture1, texCoords), 0.2);
}

