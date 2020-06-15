package kr.codesquad.issuetracker09.web.issue.dto;

import lombok.Getter;
import lombok.ToString;

import java.util.ArrayList;
import java.util.List;

@ToString
@Getter
public class PatchCloseIssueRequestDTO {
    List<Long> idList = new ArrayList<>();
    Boolean open;
}
