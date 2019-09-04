package medical.iot.platform.repositories;

import medical.iot.platform.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmailOrUsername(String email, String username);

    Optional<User> findByUsername(String username);

    Optional<User> findByUniqueId(String uniqueId);

}
