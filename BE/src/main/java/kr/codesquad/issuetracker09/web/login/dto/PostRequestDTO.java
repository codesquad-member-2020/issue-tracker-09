package kr.codesquad.issuetracker09.web.login.dto;

import lombok.*;

@ToString
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PostRequestDTO {

    private String jwtToken;
}
