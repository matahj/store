package mx.uam.cua.store.service.impl;

import mx.uam.cua.store.dto.UserDTO;
import mx.uam.cua.store.entity.UserEntity;
import mx.uam.cua.store.mapper.UserMapper;
import mx.uam.cua.store.repository.UserReposiroty;
import mx.uam.cua.store.service.UserService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    private final UserMapper userMapper;
    private final UserReposiroty userReposiroty;

    public UserServiceImpl(UserMapper userMapper, UserReposiroty userReposiroty) {
        this.userMapper = userMapper;
        this.userReposiroty = userReposiroty;
    }

    @Override
    public UserDTO save(UserDTO userDTO) {

        UserEntity userEntity = userMapper.toUserEntity(userDTO);
        userEntity = userReposiroty.save(userEntity);
        return userMapper.toUserDTO(userEntity);
    }

    @Override
    public List<UserDTO> findAll() {
        List<UserEntity> userEntities = userReposiroty.findAll();

        List<UserDTO> userDTOs = new ArrayList<>();

        for (UserEntity userEntity : userEntities) {
            userDTOs.add(userMapper.toUserDTO(userEntity));
        }

        return userDTOs;
    }
}
