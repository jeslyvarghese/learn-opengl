//
//  GLBuffer.cpp
//  OpenGL Lessons
//
//  Created by Jesly Varghese on 15/04/18.
//  Copyright © 2018 Jesly. All rights reserved.
//
#include "GL/glew.h"
#include "GLBuffer.hpp"
#include <array>

GLBuffer::GLBuffer() {
    glGenVertexArrays(1, &_VAO);
}

GLuint GLBuffer::getVertexArrayObject() {
    return _VAO;
}

GLuint GLBuffer::createStaticDrawArrayBuffer(const GLfloat* array, GLuint size) {
    GLuint arrayBuffer;
    glGenBuffers(1, &arrayBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, arrayBuffer);
    glBufferData(GL_ARRAY_BUFFER, size, array, GL_STATIC_DRAW);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    return arrayBuffer;
}

GLuint GLBuffer::createStaticDrawElementBuffer(const GLuint* array, GLuint size) {
    GLuint arrayBuffer;
    glGenBuffers(1, &arrayBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, arrayBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, size, array, GL_STATIC_DRAW);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    return arrayBuffer;
}
