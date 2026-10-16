package mx.uam.cua.store.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/test")
public class TestController {

  @GetMapping("/hola")
  public String hola(){
      System.out.println("Ejecutando hola");
      return "Hola desde Sprign";
  }

}
