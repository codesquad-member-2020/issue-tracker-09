package kr.codesquad.issuetracker09.domain;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface IssueRepository extends JpaRepository<Issue, Long> {

    @Query(value = "SELECT milestone_id FROM issue WHERE id = :id", nativeQuery = true)
    Long findMilestoneIdByIssueId(@Param("id") Long issueId);

}
