package com.cardatechnologies.docker.example.spboot.controller;

import com.cardatechnologies.docker.example.spboot.travail.HeavyLifting;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SpBootController {

    //  Never do any heavy lifting here.  Shunt off all business logic to
    //  a separate jar.
    @RequestMapping("/serviceTest1")
    public String serviceTest1(){

        String retString= null;
        try{
            //
            HeavyLifting heavyLifting = new HeavyLifting();
            retString = heavyLifting.runIt();
        }
        catch( Exception ex ){

        }
        finally{

        }

        return( retString );
    }




}
