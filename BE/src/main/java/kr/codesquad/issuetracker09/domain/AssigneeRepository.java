package kr.codesquad.issuetracker09.domain;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AssigneeRepository extends JpaRepository<Assignee, Long> {
    List<Assignee> findAssigneesByIssue_Id(Long id);
}
