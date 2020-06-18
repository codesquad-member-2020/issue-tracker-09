package kr.codesquad.issuetracker09.domain;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import javax.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
@Entity
public class Milestone {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;
    private String contents;

    @Column(name = "due_on")
    private LocalDate dueOn;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    @OneToMany(mappedBy = "milestone")
    private List<Issue> issues = new ArrayList<>();

    public Long getNumberOfOpenIssue() {
        Long numberOfOpenMilestone = issues.stream()
                .filter(Issue::isOpen).count();
        return numberOfOpenMilestone;
    }

    public Long getNumberOfClosedIssue() {
        Long numberOfOpenMilestone = issues.stream()
                .filter(x -> !x.isOpen()).count();
        return numberOfOpenMilestone;
    }
}
