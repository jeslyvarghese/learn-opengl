//
//  Texture.cpp
//  OpenGL Lessons
//
//  Created by Jesly Varghese on 24/04/18.
//  Copyright © 2018 Jesly. All rights reserved.
//

#include "Texture.hpp"
Texture2D::Texture2D(std::string texturePath) {
    stbi_set_flip_vertically_on_load(true);
    _filepath = texturePath;
}

Texture2D::~Texture2D() {
    stbi_image_free(_data);
    _data = NULL;
}

void Texture2D::setWrap(GLenum wrapS, GLenum wrapT) {
    _wrapS = wrapS;
    _wrapT = wrapT;
}

void Texture2D::setMinMag(GLenum min, GLenum mag) {
    _minFilter = min;
    _magFilter = mag;
}

void Texture2D::setActiveTexture(GLenum activeTexture) {
    _activeTexture = activeTexture;
}

void Texture2D::load() {
    glGenTextures(1, &_texture);
    glBindTexture(GL_TEXTURE_2D, _texture);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, _wrapS);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, _wrapT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, _minFilter);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, _magFilter);
    _data = stbi_load(_filepath.c_str(), &_width, &_height, &_nrChannels, 0);
    if (_data) {
        GLenum channels;
        if (_nrChannels == 3) {
            channels = GL_RGB;
        } else {
            channels = GL_RGBA;
        }
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, _width, _height, 0, channels, GL_UNSIGNED_BYTE, _data);
        glGenerateMipmap(GL_TEXTURE_2D);
        stbi_image_free(_data);
        _data = NULL;
    } else {
        std::cerr << "Failed to load texture" << std::endl;
    }
}

void Texture2D::bind() {
    glActiveTexture(_activeTexture);
    glBindTexture(GL_TEXTURE_2D, _texture);
}
