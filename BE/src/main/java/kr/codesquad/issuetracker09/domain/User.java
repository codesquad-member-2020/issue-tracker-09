package kr.codesquad.issuetracker09.domain;

import lombok.*;

import javax.persistence.*;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "name")
    private String name;
    @Column(name = "social_id")
    private Long socialId;
    @Column(name = "email")
    private String email;

    public static User insert(Long id, String name, Long socialId, String email) {
        return new User(id, name, socialId, email);
    }
}
