package kr.codesquad.issuetracker09.service;

import kr.codesquad.issuetracker09.domain.Issue;
import kr.codesquad.issuetracker09.domain.IssueRepository;
import kr.codesquad.issuetracker09.domain.Milestone;
import kr.codesquad.issuetracker09.domain.MilestoneRepository;
import kr.codesquad.issuetracker09.exception.NotFoundException;
import kr.codesquad.issuetracker09.web.issue.dto.PatchDetailRequestDTO;
import org.omg.CosNaming.NamingContextPackage.NotFound;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class IssueService {
    private static final Logger log = LoggerFactory.getLogger(IssueService.class);
    private IssueRepository issueRepository;
    private MilestoneRepository milestoneRepository;

    public IssueService(IssueRepository issueRepository, MilestoneRepository milestoneRepository) {
        this.issueRepository = issueRepository;
        this.milestoneRepository = milestoneRepository;
    }

    public Issue findById(Long id) throws NotFound {
        Issue issue = issueRepository.findById(id).orElseThrow(NotFound::new);
        return issue;
    }

    public boolean editDetail(Long issueId, PatchDetailRequestDTO request) {
        log.debug("[*] editDetail - issueId : {}, request : {}", issueId, request);
        String targetKey = request.findNotNullField();
        log.debug("[*] targetKey : {}", targetKey);
        switch (targetKey) {
            case "assignee":
                break;
            case "label":
                break;
            case "milestone":
                milestoneUpdate(issueId, request.getMilestone());
                break;
            default:
                return false;
        }
        return true;
    }

    public void milestoneUpdate(Long issueId, Long milestoneId) {
        Issue issue = issueRepository.findById(issueId).orElseThrow(() -> new NotFoundException("Issue doesn't exist"));
        Milestone milestone = milestoneRepository.findById(milestoneId).orElseThrow(() -> new NotFoundException("Milestone doesn't exit"));
        issue.editMilestone(milestone);
        issueRepository.save(issue);
    }
}
