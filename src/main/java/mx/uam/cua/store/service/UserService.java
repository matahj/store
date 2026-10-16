package mx.uam.cua.store.service;

import mx.uam.cua.store.dto.UserDTO;

import java.util.List;

public interface UserService {
    UserDTO save(UserDTO userDTO);
    List<UserDTO> findAll();

}
