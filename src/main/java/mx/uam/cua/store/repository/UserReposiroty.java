package mx.uam.cua.store.repository;

import mx.uam.cua.store.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserReposiroty extends JpaRepository<UserEntity, Long> {

}
