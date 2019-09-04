package medical.iot.platform.entities;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "investigations")
public class Investigation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "patient_id")
    private User patient;

    @OneToMany(
            mappedBy = "investigation",
            cascade = CascadeType.ALL,
            orphanRemoval = true,
            fetch = FetchType.LAZY
    )
    private List<Diagnostic> diagnosticList;

    @Column(columnDefinition="Timestamp default current_timestamp")
    private Timestamp timestamp;

    public String getType() {
        return name.substring(0, name.length() - 5).toUpperCase();
    }

    public String getDiagnostics() {
        if (diagnosticList == null || diagnosticList.isEmpty()) {
            return "";
        } else {
            StringBuilder sb = new StringBuilder();
            for (Diagnostic diagnostic : diagnosticList) {
                sb.append("<b>" + diagnostic.getDescription() + "</b> <i>by " + diagnostic.getDoctor().getName() + " at " + diagnostic.getTimestamp() + "</i>");
                sb.append("<br />");
            }
            return sb.toString();
        }
    }
}
