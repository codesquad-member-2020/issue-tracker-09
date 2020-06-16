package kr.codesquad.issuetracker09.web.label.dto;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;

@ToString
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class GetLabelListResponseDTO {
    private Long id;
    private String title;
    private String contents;
    private String colorCode;
}
