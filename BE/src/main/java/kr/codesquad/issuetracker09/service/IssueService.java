package kr.codesquad.issuetracker09.service;

import kr.codesquad.issuetracker09.domain.*;
import kr.codesquad.issuetracker09.exception.NotFoundException;
import kr.codesquad.issuetracker09.web.issue.dto.PatchDetailRequestDTO;
import org.omg.CosNaming.NamingContextPackage.NotFound;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class IssueService {
    private static final Logger log = LoggerFactory.getLogger(IssueService.class);
    private IssueRepository issueRepository;
    private MilestoneRepository milestoneRepository;
    private LabelRepository labelRepository;
    private IssueLabelService issueLabelService;

    public IssueService(IssueRepository issueRepository, MilestoneRepository milestoneRepository, LabelRepository labelRepository, IssueLabelService issueLabelService) {
        this.issueRepository = issueRepository;
        this.milestoneRepository = milestoneRepository;
        this.labelRepository = labelRepository;
        this.issueLabelService = issueLabelService;
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
                labelUpdate(issueId, request.getLabel());
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

    public void labelUpdate(Long issueId, List<Long> labelIds) {
        log.debug("[*] labelUpdate - issudId : {}, labelsIds : {}", issueId, labelIds);
        Issue issue = issueRepository.findById(issueId).orElseThrow(() -> new NotFoundException("Issue doesn't exist"));
        issueLabelService.deleteByIssueId(issueId);
        for (Long labelId : labelIds) {
            Label label = labelRepository.findById(labelId).orElseThrow(() -> new NotFoundException("Label doesn't exist"));
            IssueHasLabel issueHasLabel = IssueHasLabel.builder()
                    .issue(issue)
                    .label(label)
                    .build();
            issueLabelService.save(issueHasLabel);
        }
    }
}
