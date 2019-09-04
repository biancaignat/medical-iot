package medical.iot.platform.services;

import medical.iot.platform.entities.Investigation;
import medical.iot.platform.entities.User;
import medical.iot.platform.repositories.InvestigationRepository;
import medical.iot.platform.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.Map;
import java.util.Optional;

@Service
public class InvestigationService {

    private InvestigationRepository investigationRepository;
    private UserRepository userRepository;

    @Autowired
    public InvestigationService(final InvestigationRepository investigationRepository, final UserRepository userRepository) {
        this.investigationRepository = investigationRepository;
        this.userRepository = userRepository;
    }

    public Investigation saveInvestigation(Map<String, String> properties) {
        Optional<User> userOptional = userRepository.findByUniqueId(properties.get("uniqueId"));
        User user;

        if (!userOptional.isPresent()) {
            user = new User();
            user.setUniqueId(properties.get("uniqueId"));
            userRepository.save(user);
        } else {
            user = userOptional.get();
        }

        Investigation investigation = Investigation.builder()
                .patient(user)
                .name(properties.get("invName"))
                .timestamp(new Timestamp(System.currentTimeMillis()))
                .build();

        investigationRepository.save(investigation);

        return investigation;
    }
}
