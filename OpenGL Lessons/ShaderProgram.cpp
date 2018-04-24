//
//  ShaderProgram.cpp
//  OpenGL Lessons
//
//  Created by Jesly Varghese on 15/04/18.
//  Copyright © 2018 Jesly. All rights reserved.
//
#include "ShaderProgram.hpp"
#include <fstream>
#include <iostream>
#include <vector>

ShaderProgram::~ShaderProgram() {
    glDeleteProgram(_program);
}

ShaderProgram::ShaderProgram(std::string vertexShaderPath, std::string fragmentShaderPath) {
    _vertexShader = _loadCompileShader(&vertexShaderPath[0], GL_VERTEX_SHADER);
    _fragmentShader = _loadCompileShader(&fragmentShaderPath[0], GL_FRAGMENT_SHADER);
    _program = glCreateProgram();
    glAttachShader(_program, _vertexShader);
    glAttachShader(_program, _fragmentShader);
    glLinkProgram(_program);
    glDeleteShader(_vertexShader);
    glDeleteShader(_fragmentShader);
    GLint success;
    glGetProgramiv(_program, GL_LINK_STATUS, &success);
    if (!success) {
        std::cerr << "Program link failed " << std::endl;
        std::vector<char> infoLog(512);
        glGetProgramInfoLog(_program, infoLog.size(), NULL, &infoLog[0]);
        std::cerr << &infoLog[0] << std::endl;
        glfwTerminate();
    }
}

GLuint ShaderProgram::getProgram() {
    return _program;
}

GLuint ShaderProgram::_loadCompileShader(const char *fname, GLenum shaderType) {
    std::vector<char> buffer;
    ShaderProgram::_readShaderSource(fname, buffer);
    const char *src = &buffer[0];
    
    GLuint shader = glCreateShader(shaderType);
    glShaderSource(shader, 1, &src, NULL);
    glCompileShader(shader);
    
    GLint success;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &success);
    if (!success) {
        std::cerr << "Shader compilation failed: " << std::endl;
        std::vector<char> infoLog(512);
        glGetShaderInfoLog(shader, infoLog.size(), NULL, &infoLog[0]);
        std::cerr << &infoLog[0] << std::endl;
        glfwTerminate();
        return -1;
    }
    return shader;
}

void ShaderProgram::_readShaderSource(const char *fname, std::vector<char> &buffer) {
    std::ifstream in;
    in.open(fname, std::ios::ate|std::ios::binary);
    if (in.is_open()) {
        in.seekg(0, std::ios::end);
        size_t length = (size_t)in.tellg();
        in.seekg(0, std::ios::beg);
        
        buffer.resize(length + 1);
        in.read(&buffer[0], length);
        in.close();
        
        buffer[length] = '\0';
    } else {
        std::cerr << "Unable to open " << fname << std::endl;
        exit(-1);
    }
}

GLint ShaderProgram::getAttribute(std::string attributeName) {
    return glGetAttribLocation(_program, &attributeName[0]);
    
}

GLint ShaderProgram::getUniform(std::string uniformName) {
    return glGetUniformLocation(_program, &uniformName[0]);
}
void ShaderProgram::use() {
    glUseProgram(_program);
}
