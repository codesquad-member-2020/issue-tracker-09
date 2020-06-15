package kr.codesquad.issuetracker09.web.comment.dto;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;

import java.time.LocalDate;

@ToString
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class GetCommentListResponseDTO {
    private Long id;
    private String author;
    private String contents;
    private LocalDate created;
}
