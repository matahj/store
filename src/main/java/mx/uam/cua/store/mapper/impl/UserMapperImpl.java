package mx.uam.cua.store.mapper.impl;

import mx.uam.cua.store.dto.UserDTO;
import mx.uam.cua.store.entity.UserEntity;
import mx.uam.cua.store.mapper.UserMapper;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

@Component
public class UserMapperImpl implements UserMapper {

    @Override
    public UserEntity toUserEntity(UserDTO userDTO) {
        UserEntity userEntity = new UserEntity();

        BeanUtils.copyProperties(userDTO, userEntity);

        return userEntity;
    }

    @Override
    public UserDTO toUserDTO(UserEntity userEntity) {
        UserDTO userDTO = new UserDTO();

        BeanUtils.copyProperties(userEntity, userDTO);

        return userDTO;
    }
}
