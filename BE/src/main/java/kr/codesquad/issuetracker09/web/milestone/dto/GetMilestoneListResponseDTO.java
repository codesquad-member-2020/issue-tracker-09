package kr.codesquad.issuetracker09.web.milestone.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;

import java.time.LocalDate;

@ToString
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
@JsonInclude(JsonInclude.Include.NON_NULL)
public class GetMilestoneListResponseDTO {
    private Long id;
    private String title;
    private String contents;
    private LocalDate dueOn;
    private Integer numberOfOpenIssue;
    private Integer numberOfClosedIssue;
}
