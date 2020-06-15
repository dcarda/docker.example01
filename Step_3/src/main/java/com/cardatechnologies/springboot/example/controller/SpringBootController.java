/* ***************************************************************************************
 * Class:  com.cardatechnologies.springboot.example.controller.ServletInitializer.java
 * Date:   2020/06/15
 * ***************************************************************************************
 */
package com.cardatechnologies.springboot.example.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cardatechnologies.springboot.example.travail.HeavyLifting;

@RestController
public class SpringBootController {
    @RequestMapping("/hi")
    public String helloWorld() {
        String retString = null;

        try {

            //
            HeavyLifting heavyLifting = new HeavyLifting();

            retString = heavyLifting.runIt();
        } catch (Exception ex) {}
        finally {}

        return (retString);
    }
}

/* ***************************************************************************************
 * Class:  com.cardatechnologies.springboot.example.controller.ServletInitializer.java
 * Date:   2020/06/15
 * ************************************************************************************* */
