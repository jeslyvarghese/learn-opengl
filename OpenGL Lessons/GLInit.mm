//
//  GLInit.mm
//  OpenGL Lessons
//
//  Created by Jesly Varghese on 15/04/18.
//  Copyright © 2018 Jesly. All rights reserved.
//

#include "GLInit.hpp"
void _framebuffer_size_callback(GLFWwindow *window, int width, int height);

GLInit::GLInit(std::string windowName, int width, int height) {
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwWindowHint(GLFW_OPENGL_DEBUG_CONTEXT, GLFW_TRUE);
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
    _window = glfwCreateWindow(width, height, windowName.c_str(), NULL, NULL);
    if (_window == NULL) {
        std::cerr << "Failed to create GLFW window" << std::endl;
        glfwTerminate();
    }
    int screenWidth, screenHeight;
    glfwGetFramebufferSize(_window, &screenWidth, &screenHeight);
    glfwMakeContextCurrent(_window);
    glfwSetFramebufferSizeCallback(_window, _framebuffer_size_callback);
    
    glewExperimental = GL_TRUE;
    if (GLEW_OK != glewInit()) {
        std::cerr << "Failed to initialize GLEW" << std::endl;
    }
    glViewport(0, 0, screenWidth, screenHeight);
}

GLInit::~GLInit() {
    glfwTerminate();
}

GLFWwindow* GLInit::getWindow() {
    return _window;
}

void _framebuffer_size_callback(GLFWwindow *window, int width, int height) {
    glViewport(0, 0, width, height);
}

