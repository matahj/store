package mx.uam.cua.store.mapper;

import mx.uam.cua.store.dto.UserDTO;
import mx.uam.cua.store.entity.UserEntity;

public interface UserMapper {
    UserEntity toUserEntity(UserDTO userDTO);

    UserDTO toUserDTO(UserEntity userEntity);
}
