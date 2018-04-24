//
//  ShaderProgram.hpp
//  OpenGL Lessons
//
//  Created by Jesly Varghese on 15/04/18.
//  Copyright © 2018 Jesly. All rights reserved.
//

#ifndef ShaderProgram_hpp
#define ShaderProgram_hpp

#include <stdio.h>
#include <iostream>
#include "glfw3.h"

using namespace std;

class ShaderProgram {
    GLuint _vertexShader;
    GLuint _fragmentShader;
    GLuint _program;
    GLuint _loadCompileShader(const char *fname, GLenum shaderType);
    void _readShaderSource(const char *fname, std::vector<char> &buffer);
public:
    ShaderProgram(std::string vertexShaderPath, std::string fragmentShaderPath);
    ~ShaderProgram();
    GLuint getProgram();
    GLint getAttribute(std::string attributeName);
    GLint getUniform(std::string uniformName);
    void use();
};
#endif /* ShaderProgram_hpp */
