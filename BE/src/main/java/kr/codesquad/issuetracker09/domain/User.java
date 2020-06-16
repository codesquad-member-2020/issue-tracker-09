package kr.codesquad.issuetracker09.domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
@Entity
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name")
    private String name;

    @JsonProperty("social_id")
    @Column(name = "social_id")
    private Long socialId;

    @Column(name = "email")
    private String email;

    public static User insert(Long id, String name, Long socialId, String email) {
        return new User(id, name, socialId, email);
    }
}
