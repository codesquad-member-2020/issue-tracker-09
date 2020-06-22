package kr.codesquad.issuetracker09.domain;

import lombok.Getter;

import javax.persistence.*;

@Getter
@Entity
public class IssueHasLabel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "issue_id")
    private Issue issue;

    @ManyToOne
    @JoinColumn(name = "label_id")
    private Label label;
}
