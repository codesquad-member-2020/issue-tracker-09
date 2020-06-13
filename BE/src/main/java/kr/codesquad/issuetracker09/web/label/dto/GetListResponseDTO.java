package kr.codesquad.issuetracker09.web.label.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

@ToString
@Getter
@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class GetListResponseDTO {
    private Long id;
    private String title;
    private String contents;
    private String colorCode;
}
