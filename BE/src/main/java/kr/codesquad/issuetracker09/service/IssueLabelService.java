package kr.codesquad.issuetracker09.service;

import kr.codesquad.issuetracker09.domain.IssueHasLabel;
import kr.codesquad.issuetracker09.domain.IssueHasLabelRepository;
import kr.codesquad.issuetracker09.domain.Label;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class IssueLabelService {
    private IssueHasLabelRepository issueHasLabelRepository;

    public IssueLabelService(IssueHasLabelRepository issueHasLabelRepository) {
        this.issueHasLabelRepository = issueHasLabelRepository;
    }

    public List<Label> findLabelsByIssueId(Long issueId) {
        return issueHasLabelRepository.findLabelByIssueId(issueId);
    }

    @Transactional
    public void deleteByIssueId(Long issueId) {
        issueHasLabelRepository.deleteByIssueId(issueId);
    }

    public void save(IssueHasLabel issueHasLabel) {
        issueHasLabelRepository.save(issueHasLabel);
    }
}
