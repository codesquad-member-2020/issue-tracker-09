package kr.codesquad.issuetracker09.web.comment.dto;
import lombok.*;

@ToString
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PostCommentRequestDTO {
    private Long issueId;
    private String contents;
}
