package kr.codesquad.issuetracker09.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDate;

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

    @Column(name = "number_of_open_issue")
    private Integer numberOfOpenIssue;

    @Column(name = "number_of_closed_issue")
    private Integer numberOfClosedIssue;
}
