package kr.codesquad.issuetracker09.web.milestone.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class MilestoneListDTO {
    private Long id;
    private String title;
    private String contents;
    private LocalDate dueOn;
    private Long numberOfOpenIssue;
    private Long numberOfClosedIssue;

}


