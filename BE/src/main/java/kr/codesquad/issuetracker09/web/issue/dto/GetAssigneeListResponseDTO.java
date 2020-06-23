package kr.codesquad.issuetracker09.web.issue.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Getter
public class GetAssigneeListResponseDTO {
    private Long userId;
    private String userName;
}
