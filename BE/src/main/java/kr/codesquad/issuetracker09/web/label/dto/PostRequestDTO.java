package kr.codesquad.issuetracker09.web.label.dto;
import lombok.*;

@ToString
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PostRequestDTO {
    private String title;
    private String contents;
    private String colorCode;
}
