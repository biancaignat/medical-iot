package medical.iot.platform.mqtt;

import medical.iot.platform.services.InvestigationService;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Map;

@Component
public class Subscriber {

    private InvestigationService investigationService;

    @Autowired
    public Subscriber(final InvestigationService investigationService) {
        this.investigationService = investigationService;
    }

    @RabbitListener(queues = "${jsa.rabbitmq.queue}")
    public void recievedMessage(Map<String, String> properties) {
        System.out.println("Recieved Message: " + properties);
        System.out.println("Saved investigation: " + investigationService.saveInvestigation(properties));
    }
}
