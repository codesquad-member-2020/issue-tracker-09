package kr.codesquad.issuetracker09.service;

import kr.codesquad.issuetracker09.domain.Assignee;
import kr.codesquad.issuetracker09.domain.AssigneeRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AssigneeService {
    private AssigneeRepository assigneeRepository;

    public AssigneeService(AssigneeRepository assigneeRepository) {
        this.assigneeRepository = assigneeRepository;
    }

    public List<Assignee> findAllAssigneeByIssueId(Long issueId) {
        return assigneeRepository.findAssigneesByIssue_Id(issueId);
    }
}
