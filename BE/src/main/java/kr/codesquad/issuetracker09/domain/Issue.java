package kr.codesquad.issuetracker09.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import kr.codesquad.issuetracker09.web.comment.dto.PostCommentRequestDTO;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Setter
@Builder
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Issue {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    private String contents;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime created;

    private boolean open;

    @Column(name = "is_deleted")
    private boolean isDeleted;

    @ManyToOne
    @JoinColumn(name = "milestone_id")
    private Milestone milestone;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID")
    private User author;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "ISSUE_ID")
    private List<Comment> comments = new ArrayList<>();

    @OneToMany(mappedBy = "issue")
    private List<IssueHasLabel> issueHasLabels = new ArrayList<>();

    @OneToMany(mappedBy = "issue")
    private List<Assignee> assignees = new ArrayList<>();

    public void editMilestone(Milestone milestone) {
        this.milestone = milestone;
    }

    public void addComment(User user, PostCommentRequestDTO commentDTO) {
        Comment comment = new Comment.CommentBuilder()
                .contents(commentDTO.getContents())
                .author(user)
                .created(LocalDateTime.now())
                .build();
        comments.add(comment);
    }
}
