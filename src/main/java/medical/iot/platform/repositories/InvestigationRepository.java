package medical.iot.platform.repositories;

import medical.iot.platform.entities.Investigation;
import medical.iot.platform.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface InvestigationRepository extends JpaRepository<Investigation, Long> {

}
