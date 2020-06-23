package kr.codesquad.issuetracker09.web.issue.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@ToString
public class PatchDetailRequestDTO {
    private List<Long> assignee;
    private List<Long> label;
    private Long milestone;

    public String findNotNullField() {
        if (assignee != null) {
            return "assignee";
        }

        if (label != null) {
            return "label";
        }

        if (milestone != null) {
            return "milestone";
        }

        return null;
    }
}
