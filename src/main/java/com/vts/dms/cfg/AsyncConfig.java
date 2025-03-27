package com.vts.dms.cfg;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;

@Configuration
@EnableAsync
public class  AsyncConfig{
    //AsyncConfig class, is necessary to enable asynchronous processing in your Spring application. 
//If you omit this @EnableAsync Spring will not recognize the @Async annotation in your service methods, and asynchronous processing won't work as expected.
}  