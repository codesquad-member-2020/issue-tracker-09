package kr.codesquad.issuetracker09.domain;

import kr.codesquad.issuetracker09.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findUserBySocialId(Long socialId);
}
