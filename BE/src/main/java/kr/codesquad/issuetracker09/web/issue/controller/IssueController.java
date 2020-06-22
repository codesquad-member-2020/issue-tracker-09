package kr.codesquad.issuetracker09.web.issue.controller;

import kr.codesquad.issuetracker09.domain.Comment;
import kr.codesquad.issuetracker09.domain.Issue;
import kr.codesquad.issuetracker09.domain.Label;
import kr.codesquad.issuetracker09.domain.Milestone;
import kr.codesquad.issuetracker09.service.IssueLabelService;
import kr.codesquad.issuetracker09.service.IssueService;
import kr.codesquad.issuetracker09.service.LabelService;
import kr.codesquad.issuetracker09.web.comment.dto.GetCommentListResponseDTO;
import kr.codesquad.issuetracker09.web.issue.dto.GetIssueDetailResponseDTO;
import kr.codesquad.issuetracker09.web.label.dto.GetLabelListResponseDTO;
import kr.codesquad.issuetracker09.web.milestone.dto.GetMilestoneListResponseDTO;
import org.omg.CosNaming.NamingContextPackage.NotFound;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RequestMapping("/issues")
@RestController
public class IssueController {
    private static final Logger log = LoggerFactory.getLogger(IssueController.class);

    private IssueService issueService;
    private IssueLabelService issueLabelService;
    private LabelService labelService;

    public IssueController(IssueService issueService, IssueLabelService issueLabelService, LabelService labelService) {
        this.issueService = issueService;
        this.issueLabelService = issueLabelService;
        this.labelService = labelService;
    }

    @GetMapping("/{issue-id}/detail")
    public GetIssueDetailResponseDTO detail(@PathVariable(name = "issue-id") long issueId) throws NotFound {
        Issue issue = issueService.findById(issueId);
        GetIssueDetailResponseDTO detail = GetIssueDetailResponseDTO.builder()
                .issueId(issueId)
                .title(issue.getTitle())
                .contents(issue.getContents())
                .author(issue.getAuthor().getName())
                .open(issue.isOpen())
                .build();

        List<GetCommentListResponseDTO> comments = new ArrayList<>();
        for (Comment comment : issue.getComments()) {
            comments.add(GetCommentListResponseDTO.builder()
                    .id(comment.getId())
                    .author(comment.getAuthor().getName())
                    .contents(comment.getContents())
                    .created(comment.getCreated())
                    .build());
        }

        detail.setComments(comments);

        Milestone milestone = issue.getMilestone();
        detail.setMilestones(GetMilestoneListResponseDTO.builder()
                .id(milestone.getId())
                .title(milestone.getTitle())
                .dueOn(milestone.getDueOn())
                .numberOfOpenIssue(milestone.getNumberOfOpenIssue())
                .numberOfClosedIssue(milestone.getNumberOfClosedIssue())
                .build());

        List<Label> labels = issueLabelService.findLabelsByIssueId(issueId);
        List<GetLabelListResponseDTO> labelDTOs = new ArrayList<>();
        for (Label label : labels) {
            labelDTOs.add(GetLabelListResponseDTO.builder()
                    .id(label.getId())
                    .title(label.getTitle())
                    .colorCode(label.getColorCode())
                    .build());
        }

        detail.setLabels(labelDTOs);
        return detail;
    }

}
