package mx.uam.cua.store.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/test")
public class JorgeController {

    @GetMapping("/jorge")
    public String jorge(){
        return "Endpoint de jorge";
    }
}
