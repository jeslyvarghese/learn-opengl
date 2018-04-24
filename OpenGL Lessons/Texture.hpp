//
//  Texture.hpp
//  OpenGL Lessons
//
//  Created by Jesly Varghese on 24/04/18.
//  Copyright © 2018 Jesly. All rights reserved.
//

#ifndef Texture_hpp
#define Texture_hpp

#include <stdio.h>
#include <iostream>
#include "GL/glew.h"
#include "stb_image.h"
#include <OpenGL/gl3.h>
#import "glfw3.h"

class Texture2D {
    GLint _width, _height, _nrChannels;
    unsigned char * _data;
    std::string _filepath;
    GLenum _wrapS, _wrapT, _minFilter, _magFilter, _activeTexture;
    GLuint _texture;
public:
    Texture2D(std::string texturePath);
    ~Texture2D();
    void setWrap(GLenum wrapS, GLenum wrapT);
    void setMinMag(GLenum min, GLenum mag);
    void setActiveTexture(GLenum activeTexture);
    void load();
    void get();
    void bind();
};
#endif /* Texture_hpp */
