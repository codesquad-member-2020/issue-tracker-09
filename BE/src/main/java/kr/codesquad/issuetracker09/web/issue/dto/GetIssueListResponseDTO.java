package kr.codesquad.issuetracker09.web.issue.dto;

import kr.codesquad.issuetracker09.web.label.dto.GetLabelListResponseDTO;
import kr.codesquad.issuetracker09.web.milestone.dto.GetMilestoneListResponseDTO;
import lombok.*;

import java.util.List;

@ToString
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GetIssueListResponseDTO {
    private Long issueId;
    private String contents;
    private String title;
    private GetMilestoneListResponseDTO milestone;
    private List<GetLabelListResponseDTO> labels;

    public void setMilestone(GetMilestoneListResponseDTO milestone) {
        this.milestone = milestone;
    }

    public void setLabels(List<GetLabelListResponseDTO> labels) {
        this.labels = labels;
    }
}
