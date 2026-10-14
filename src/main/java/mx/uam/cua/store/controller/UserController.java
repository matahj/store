package mx.uam.cua.store.controller;

import mx.uam.cua.store.dto.UserDTO;
import mx.uam.cua.store.service.UserService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/v1")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/users")
    public UserDTO save(@RequestBody UserDTO userDTO){
        UserDTO newUserDTO = userService.save(userDTO);
        return newUserDTO;
    }
}
