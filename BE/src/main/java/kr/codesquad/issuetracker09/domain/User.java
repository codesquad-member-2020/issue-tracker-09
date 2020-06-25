package kr.codesquad.issuetracker09.domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

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
    private String socialId;

    @Column(name = "email")
    private String email;

    @Builder.Default
    @OneToMany(mappedBy = "user")
    private List<Assignee> assigneeList = new ArrayList<>();
}
