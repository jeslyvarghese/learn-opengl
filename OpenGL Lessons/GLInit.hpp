//
//  GLInit.hpp
//  OpenGL Lessons
//
//  Created by Jesly Varghese on 15/04/18.
//  Copyright © 2018 Jesly. All rights reserved.
//

#ifndef GLInit_hpp
#define GLInit_hpp
#include "GL/glew.h"
#import <Cocoa/Cocoa.h>
#include <OpenGL/gl3.h>
#import "glfw3.h"
#include <stdio.h>
#include <iostream>
using namespace std;

class GLInit {
    GLFWwindow *_window;
public:
    GLInit(std::string windowName, int width, int height);
    ~GLInit();
    GLFWwindow* getWindow();
};
#endif /* GLInit_hpp */
