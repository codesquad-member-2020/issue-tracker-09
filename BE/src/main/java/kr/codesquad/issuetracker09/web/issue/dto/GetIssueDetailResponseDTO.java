package kr.codesquad.issuetracker09.web.issue.dto;

import kr.codesquad.issuetracker09.web.comment.dto.GetCommentListResponseDTO;
import kr.codesquad.issuetracker09.web.label.dto.GetLabelListResponseDTO;
import kr.codesquad.issuetracker09.web.milestone.dto.GetMilestoneListResponseDTO;
import lombok.*;

import java.util.List;

@ToString
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GetIssueDetailResponseDTO {
    private Long issueId;
    private String title;
    private String contents;
    private String author;
    private Boolean open;
    private List<GetCommentListResponseDTO> comments;
    private List<GetLabelListResponseDTO> labels;
    private GetMilestoneListResponseDTO milestones;

    public void setComments(List<GetCommentListResponseDTO> comments) {
        this.comments = comments;
    }

    public void setLabels(List<GetLabelListResponseDTO> labels) {
        this.labels = labels;
    }

    public void setMilestones(GetMilestoneListResponseDTO milestones) {
        this.milestones = milestones;
    }
}
