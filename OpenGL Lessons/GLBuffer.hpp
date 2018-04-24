//
//  GLBuffer.hpp
//  OpenGL Lessons
//
//  Created by Jesly Varghese on 15/04/18.
//  Copyright © 2018 Jesly. All rights reserved.
//

#ifndef GLBuffer_hpp
#define GLBuffer_hpp

#include <stdio.h>
#import "glfw3.h"
#include <iostream>
class GLBuffer {
    GLuint _VAO;
public:
    GLBuffer();
    GLuint getVertexArrayObject();
    GLuint createStaticDrawArrayBuffer(const GLfloat* array, GLuint size);
    GLuint createStaticDrawElementBuffer(const GLuint* array, GLuint size);
};
#endif /* GLBuffer_hpp */
