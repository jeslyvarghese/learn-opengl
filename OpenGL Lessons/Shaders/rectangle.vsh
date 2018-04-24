#version 330

in vec3 position;
in vec3 color;
in vec2 tex;
uniform mat4 transform;
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
out vec4 vertexColor;
out vec2 texCoords;

void main()
{
    vertexColor = vec4(color, 1.0);
    texCoords = tex;
    gl_Position = projection * view * model * vec4(position, 1.0);
}

