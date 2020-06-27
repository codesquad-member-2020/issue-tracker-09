package kr.codesquad.issuetracker09.service;

import kr.codesquad.issuetracker09.domain.*;
import kr.codesquad.issuetracker09.exception.NotFoundException;
import kr.codesquad.issuetracker09.web.issue.dto.FilterDTO;
import kr.codesquad.issuetracker09.web.issue.dto.PatchDetailRequestDTO;
import org.omg.CosNaming.NamingContextPackage.NotFound;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.*;
import java.util.List;

@Service
public class IssueService {
    private static final Logger log = LoggerFactory.getLogger(IssueService.class);
    private IssueRepository issueRepository;
    private MilestoneRepository milestoneRepository;
    private LabelRepository labelRepository;
    private IssueLabelService issueLabelService;
    private AssigneeService assigneeService;
    private UserService userService;

    @PersistenceContext
    private EntityManager entityManager;

    public IssueService(IssueRepository issueRepository, MilestoneRepository milestoneRepository, LabelRepository labelRepository,
                        IssueLabelService issueLabelService, AssigneeService assigneeService, UserService userService) {
        this.issueRepository = issueRepository;
        this.milestoneRepository = milestoneRepository;
        this.labelRepository = labelRepository;
        this.issueLabelService = issueLabelService;
        this.assigneeService = assigneeService;
        this.userService = userService;
    }

    public Issue findById(Long id) throws NotFound {
        Issue issue = issueRepository.findById(id).orElseThrow(NotFound::new);
        return issue;
    }

    public boolean editDetail(Long issueId, PatchDetailRequestDTO request) {
        log.debug("[*] editDetail - issueId : {}, request : {}", issueId, request);
        String targetKey = request.findNotNullField();
        log.debug("[*] targetKey : {}", targetKey);
        Issue issue = issueRepository.findById(issueId).orElseThrow(() -> new NotFoundException("Issue doesn't exist"));
        switch (targetKey) {
            case "assignee":
                updateAssignee(issue, request.getAssignee());
                break;
            case "label":
                updateLabel(issue, request.getLabel());
                break;
            case "milestone":
                updateMilestone(issue, request.getMilestone());
                break;
            default:
                return false;
        }
        return true;
    }

    public void updateMilestone(Issue issue, Long milestoneId) {
        Milestone milestone = milestoneRepository.findById(milestoneId).orElseThrow(() -> new NotFoundException("Milestone doesn't exit"));
        issue.editMilestone(milestone);
        issueRepository.save(issue);
    }

    public void updateLabel(Issue issue, List<Long> labelIds) {
        log.debug("[*] update Label - issudId : {}, labelsIds : {}", issue.getId(), labelIds);
        issueLabelService.deleteByIssueId(issue.getId());
        for (Long labelId : labelIds) {
            Label label = labelRepository.findById(labelId).orElseThrow(() -> new NotFoundException("Label doesn't exist"));
            IssueHasLabel issueHasLabel = IssueHasLabel.builder()
                    .issue(issue)
                    .label(label)
                    .build();
            issueLabelService.save(issueHasLabel);
        }
    }

    public void updateAssignee(Issue issue, List<Long> userIds) {
        log.debug("[*] update Assignee - issudId : {}, assignees : {}", issue.getId(), userIds);
        assigneeService.deleteByIssueId(issue.getId());
        for (Long userId : userIds) {
            User user = userService.findUser(userId);
            Assignee assignee = Assignee.builder()
                    .user(user)
                    .issue(issue)
                    .build();
            assigneeService.save(assignee);
        }
    }

    public List<Issue> getIssueByFilter(FilterDTO filterDTO) {
        // Criteria 사용 준비
        CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<Issue> query = cb.createQuery(Issue.class);

        // 루트 클래스 (조회를 시작할 클래스)
        Root<Issue> issue = query.from(Issue.class);

        //쿼리 생성
        CriteriaQuery<Issue> criteriaQuery = query.select(issue);
        // Join - Issue, Assignee
        Join<Issue, Assignee> issueAssignee = issue.join("assignees", JoinType.INNER);

        // 조건 1 - is : open or closed
        if (filterDTO.isClosed()) {
            criteriaQuery.where(cb.equal(issue.get("open"), false));
        }

        if (filterDTO.isOpened()) {
            criteriaQuery.where(cb.equal(issue.get("open"), true));
        }

        if (filterDTO.getAuthor() != null) {
            User user = userService.findUser(filterDTO.getAuthor());
            criteriaQuery.where(cb.equal(issue.get("author"), user));
        }

        List<Issue> resultIssue = entityManager.createQuery(criteriaQuery).getResultList();
        return resultIssue;
    }
}
