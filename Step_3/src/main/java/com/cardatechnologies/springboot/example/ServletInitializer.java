/* ***************************************************************************************
 * Class:  com.cardatechnologies.springboot.example.ServletInitializer.java
 * Date:   2020/06/15
 * ***************************************************************************************
 */
package com.cardatechnologies.springboot.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

public class ServletInitializer extends SpringBootServletInitializer {
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(DemoApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(ServletInitializer.class, args);
    }
}

/* ***************************************************************************************
 * Class:  com.cardatechnologies.springboot.example.ServletInitializer.java
 * Date:   2020/06/15
 * ************************************************************************************* */
