package kr.codesquad.issuetracker09.web.issue.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

import java.util.List;

@ToString
@Getter
@Builder
public class GetListResponseDTO {
    private Long issueId;
    private String contents;
    private String title;
    private kr.codesquad.issuetracker09.web.milestone.dto.GetListResponseDTO milestone;
    private List<kr.codesquad.issuetracker09.web.label.dto.GetListResponseDTO> labels;

    public void setMilestone(kr.codesquad.issuetracker09.web.milestone.dto.GetListResponseDTO milestone) {
        this.milestone = milestone;
    }

    public void setLabels(List<kr.codesquad.issuetracker09.web.label.dto.GetListResponseDTO> labels) {
        this.labels = labels;
    }
}
