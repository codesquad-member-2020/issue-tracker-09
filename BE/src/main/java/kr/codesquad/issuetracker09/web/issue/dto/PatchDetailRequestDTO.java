package kr.codesquad.issuetracker09.web.issue.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PatchDetailRequestDTO {
    private long assignee;
    private long label;
    private long milesttone;
}
