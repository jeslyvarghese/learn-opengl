//
//  main.m
//  OpenGL Lessons
//
//  Created by Jesly Varghese on 14/04/18.
//  Copyright © 2018 Jesly. All rights reserved.
//

#include "GL/glew.h"
#include "stb_image.h"
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

#include <OpenGL/gl3.h>

#import "glfw3.h"
#include "GLBuffer.hpp"
#include "GLInit.hpp"
#include "ShaderProgram.hpp"
#include "glm.hpp"
#include "gtc/matrix_transform.hpp"
#include "gtc/type_ptr.hpp"
#include "Texture.hpp"

void framebuffer_size_callback(GLFWwindow *window, int width, int height);
void processInput(GLFWwindow *window);
void mouseCallback(GLFWwindow *window, double xpos, double ypos);
void scrollCallback(GLFWwindow *window, double xoffset, double yoffset);

glm::vec3 cameraPos = glm::vec3(0.f, 0.f, 3.f);
glm::vec3 cameraFront = glm::vec3(0.f, 0.f, -1.f);
glm::vec3 cameraUp = glm::vec3(0.f, 1.f, 0.f);

GLfloat deltaTime = 0.f;
GLfloat lastFrame = 0.f;
GLfloat fov = 45.f;
GLfloat lastX = 400, lastY = 300, yaw =  0, pitch = 0;
GLboolean firstMouse = true;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        GLInit glInit = GLInit("Learn OpenGL", 800, 600);
        GLFWwindow *window = glInit.getWindow();
        glfwSetInputMode(window, GLFW_CURSOR, GLFW_CURSOR_DISABLED);
        glfwSetCursorPosCallback(window, mouseCallback);
        glfwSetScrollCallback(window, scrollCallback);
        ShaderProgram program = ShaderProgram("/Users/jeslyvarghese/Workspace/Extra/Open GL/Lessons/OpenGL Lessons/OpenGL Lessons/Shaders/rectangle.vsh", "/Users/jeslyvarghese/Workspace/Extra/Open GL/Lessons/OpenGL Lessons/OpenGL Lessons/Shaders/rectangle.fsh");
        GLuint shaderProgram = program.getProgram();
        program.use();
        
        GLfloat vertices[] = {
            -0.5f, -0.5f, -0.5f,  0.0f, 0.0f,
            0.5f, -0.5f, -0.5f,  1.0f, 0.0f,
            0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
            0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
            -0.5f,  0.5f, -0.5f,  0.0f, 1.0f,
            -0.5f, -0.5f, -0.5f,  0.0f, 0.0f,
            
            -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
            0.5f, -0.5f,  0.5f,  1.0f, 0.0f,
            0.5f,  0.5f,  0.5f,  1.0f, 1.0f,
            0.5f,  0.5f,  0.5f,  1.0f, 1.0f,
            -0.5f,  0.5f,  0.5f,  0.0f, 1.0f,
            -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
            
            -0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
            -0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
            -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
            -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
            -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
            -0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
            
            0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
            0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
            0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
            0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
            0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
            0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
            
            -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
            0.5f, -0.5f, -0.5f,  1.0f, 1.0f,
            0.5f, -0.5f,  0.5f,  1.0f, 0.0f,
            0.5f, -0.5f,  0.5f,  1.0f, 0.0f,
            -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
            -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
            
            -0.5f,  0.5f, -0.5f,  0.0f, 1.0f,
            0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
            0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
            0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
            -0.5f,  0.5f,  0.5f,  0.0f, 0.0f,
            -0.5f,  0.5f, -0.5f,  0.0f, 1.0f
        };
        
        GLuint indices[] = {
            0, 1, 3,   // first triangle
            1, 2, 3    // second triangle
        };
        
        GLBuffer buffer = GLBuffer();
        GLuint VAO = buffer.getVertexArrayObject();
        GLuint VBO = buffer.createStaticDrawArrayBuffer(vertices, sizeof(vertices));
        GLuint EBO = buffer.createStaticDrawElementBuffer(indices, sizeof(indices));
        
        glBindVertexArray(VAO);
        glBindBuffer(GL_ARRAY_BUFFER, VBO);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
        
        GLint positionAttribute = program.getAttribute("position");
        glVertexAttribPointer(positionAttribute, 3, GL_FLOAT, GL_FALSE, 5 * sizeof(GLfloat), (void*) 0);
        glEnableVertexAttribArray(positionAttribute);
        
        GLint texAttribute = program.getAttribute("tex");
        glVertexAttribPointer(texAttribute, 2, GL_FLOAT, GL_FALSE, 5 * sizeof(GLfloat), (void *) (3 * sizeof(GLfloat)));
        glEnableVertexAttribArray(texAttribute);
        
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
        glBindBuffer(GL_ARRAY_BUFFER, 0);
        glBindVertexArray(0);
        
        Texture2D textureContainer = Texture2D("/Users/jeslyvarghese/Workspace/Extra/Open GL/Lessons/OpenGL Lessons/OpenGL Lessons/Textures/container.jpg");
        textureContainer.setWrap(GL_REPEAT, GL_REPEAT);
        textureContainer.setMinMag(GL_LINEAR, GL_LINEAR);
        textureContainer.setActiveTexture(GL_TEXTURE0);
        textureContainer.load();
        
        Texture2D textureSmiley = Texture2D("/Users/jeslyvarghese/Workspace/Extra/Open GL/Lessons/OpenGL Lessons/OpenGL Lessons/Textures/awesomeface.png");
        textureSmiley.setWrap(GL_REPEAT, GL_REPEAT);
        textureSmiley.setMinMag(GL_LINEAR, GL_LINEAR);
        textureSmiley.setActiveTexture(GL_TEXTURE1);
        textureSmiley.load();
        
        glUniform1i(program.getUniform("texture0"), 0);
        glUniform1i(program.getUniform("texture1"), 1);
        
        GLuint transformAttribute = program.getUniform("transform");
        GLuint modelAttribute = program.getUniform("model");
        GLuint viewAttribute = program.getUniform("view");
        GLuint projectionAttribute = program.getUniform("projection");
        
        glEnable(GL_DEPTH_TEST);
        
        glm::vec3 cubePositions[] = {
            glm::vec3( 0.0f,  0.0f,  0.0f),
            glm::vec3( 2.0f,  5.0f, -15.0f),
            glm::vec3(-1.5f, -2.2f, -2.5f),
            glm::vec3(-3.8f, -2.0f, -12.3f),
            glm::vec3( 2.4f, -0.4f, -3.5f),
            glm::vec3(-1.7f,  3.0f, -7.5f),
            glm::vec3( 1.3f, -2.0f, -2.5f),
            glm::vec3( 1.5f,  2.0f, -2.5f),
            glm::vec3( 1.5f,  0.2f, -1.5f),
            glm::vec3(-1.3f,  1.0f, -1.5f)
        };
        
        while (!glfwWindowShouldClose(window)) {
            processInput(window);
            
            glClearColor(0.0f, 0.0f, 0.0f, 1.f);
            glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

            GLfloat radius = 10.f;
            GLfloat cameraX = sin(glfwGetTime()) * radius;
            GLfloat cameraZ = cos(glfwGetTime()) * radius;
            glm::mat4 view;
            view = glm::lookAt(cameraPos, cameraPos + cameraFront, cameraUp);
            
            glm::mat4 projection;
            projection = glm::perspective(glm::radians(fov), 800.f/600.f, 0.1f, 100.f);
            
            glUniformMatrix4fv(viewAttribute, 1, GL_FALSE, glm::value_ptr(view));
            glUniformMatrix4fv(projectionAttribute, 1, GL_FALSE, glm::value_ptr(projection));
            
            textureContainer.bind();
            textureSmiley.bind();
            
            glBindVertexArray(VAO);
            
            for (int i = 0; i < 10; i++) {
                glm::mat4 model;
                model = glm::translate(model, cubePositions[i]);
                GLfloat angle = 20.f * (i+1);
                model = glm::rotate(model, (GLfloat)glfwGetTime()*glm::radians(angle), glm::vec3(1.0f, 0.3f, 0.5f));
                glUniformMatrix4fv(modelAttribute, 1, GL_FALSE, glm::value_ptr(model));
                glDrawArrays(GL_TRIANGLES, 0, 36);
            }
            
            glBindVertexArray(0);
            
            sGLfloat currentFrame = glfwGetTime();
            deltaTime = currentFrame - lastFrame;
            lastFrame = currentFrame;
            glfwSwapBuffers(window);
            glfwPollEvents();
        }
    }
    return 0;
}

void framebuffer_size_callback(GLFWwindow *window, int width, int height) {
    glViewport(0, 0, width, height);
}

void processInput(GLFWwindow *window) {
    if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
        glfwSetWindowShouldClose(window, true);
    }
    GLfloat cameraSpeed = 2.5f * deltaTime;
    if (glfwGetKey(window, GLFW_KEY_W) == GLFW_PRESS) {
        cameraPos += cameraSpeed * cameraFront;
    }
    if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS) {
        cameraPos-= cameraSpeed * cameraFront;
    }
    if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS) {
        cameraPos -= glm::normalize(glm::cross(cameraFront, cameraUp)) * cameraSpeed;
    }
    if (glfwGetKey(window, GLFW_KEY_D) == GLFW_PRESS) {
        cameraPos += glm::normalize(glm::cross(cameraFront, cameraUp)) * cameraSpeed;
    }
}

void mouseCallback(GLFWwindow *window, double xpos, double ypos) {
    if (firstMouse) {
        lastX = xpos;
        lastY = ypos;
        firstMouse = GL_FALSE;
    }
    GLfloat xoffset = xpos - lastX;
    GLfloat yoffset = lastY - ypos;
    lastX = xpos;
    lastY = ypos;
    
    GLfloat sensitivity = 0.05f;
    xoffset *= sensitivity;
    yoffset *= sensitivity;
    
    yaw += xoffset;
    pitch  += yoffset;
    
    if (pitch > 89.f) {
        pitch = 89.f;
    }
    if (pitch < -89.f) {
        pitch = -89.f;
    }
    glm::vec3 front;
    front.x = cos(glm::radians(yaw)) * cos(glm::radians(pitch));
    front.y = sin(glm::radians(pitch));
    front.z = sin(glm::radians(yaw)) * cos(glm::radians(pitch));
    cameraFront = glm::normalize(front);
}

void scrollCallback(GLFWwindow *window, double xoffset, double yoffset) {
    if (fov >= 1.f && fov <= 45.f) {
        fov -= yoffset;
    }
    if (fov <= 1.f) {
        fov = 1.f;
    }
    if (fov >= 45.f) {
        fov = 45.f;
    }
}
