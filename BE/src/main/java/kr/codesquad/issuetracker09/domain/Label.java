package kr.codesquad.issuetracker09.domain;

import lombok.*;

import javax.persistence.*;

@Data
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Label {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    private String contents;

    @Column(name="color_code")
    private String colorCode;
}
