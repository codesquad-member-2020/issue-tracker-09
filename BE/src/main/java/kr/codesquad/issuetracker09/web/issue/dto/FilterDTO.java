package kr.codesquad.issuetracker09.web.issue.dto;

import lombok.*;

import java.util.List;

@ToString
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class FilterDTO {
    private String is;
    private Long author;
    private Long assignee;
    private Long commentedBy;
    private List<Long> labels;
    private List<Long> milestones;
}
