package medical.iot.platform.repositories;

import medical.iot.platform.entities.Diagnostic;
import medical.iot.platform.entities.Investigation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DiagnosticRepository extends JpaRepository<Diagnostic, Long> {

}
