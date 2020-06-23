package kr.codesquad.issuetracker09.domain;

import org.hibernate.annotations.SQLDelete;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AssigneeRepository extends JpaRepository<Assignee, Long> {
    List<Assignee> findAssigneesByIssue_Id(Long id);

    @SQLDelete(sql = "DELETE FROM assignee WHERE issue_id = :id")
    void deleteByIssueId(@Param("id") Long issueId);
}
