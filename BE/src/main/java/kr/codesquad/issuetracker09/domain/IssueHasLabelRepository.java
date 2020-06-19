package kr.codesquad.issuetracker09.domain;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IssueHasLabelRepository extends JpaRepository<IssueHasLabel, Long> {

    @Query(value = "SELECT label FROM IssueHasLabel WHERE issue_id = :id")
    List<Label> findLabelByIssueId(@Param("id") Long issueId);
}
