
package com.example.java_backend_api.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Sample {
    
    @GetMapping("/api")
    public String sampleAPI() {
        return "Hello World";
    }

    @GetMapping("/")
    public String home() {
        return "API is running!";
    }
}