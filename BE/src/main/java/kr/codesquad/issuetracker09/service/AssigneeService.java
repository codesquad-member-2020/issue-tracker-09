package kr.codesquad.issuetracker09.service;

import kr.codesquad.issuetracker09.domain.Assignee;
import kr.codesquad.issuetracker09.domain.AssigneeRepository;
import kr.codesquad.issuetracker09.exception.NotFoundException;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class AssigneeService {
    private final AssigneeRepository assigneeRepository;

    public AssigneeService(AssigneeRepository assigneeRepository) {
        this.assigneeRepository = assigneeRepository;
    }

    public List<Assignee> findAllAssigneeByIssueId(Long issueId) {
        return assigneeRepository.findAssigneesByIssue_Id(issueId);
    }

    @Transactional
    public void deleteByIssueId(Long issueId) {
        assigneeRepository.deleteByIssueId(issueId);
    }

    public Assignee findById(Long id) {
        return assigneeRepository.findById(id).orElseThrow(() -> new NotFoundException("Assignee doesn't exist."));
    }

    public void save(Assignee assignee) {
        assigneeRepository.save(assignee);
    }
}
