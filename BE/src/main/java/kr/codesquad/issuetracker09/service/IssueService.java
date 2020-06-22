package kr.codesquad.issuetracker09.service;

import kr.codesquad.issuetracker09.domain.Issue;
import kr.codesquad.issuetracker09.domain.IssueRepository;
import org.omg.CosNaming.NamingContextPackage.NotFound;
import org.springframework.stereotype.Service;

@Service
public class IssueService {
    private IssueRepository issueRepository;

    public IssueService(IssueRepository issueRepository) {
        this.issueRepository = issueRepository;
    }

    public Issue findById(Long id) throws NotFound {
        Issue issue = issueRepository.findById(id).orElseThrow(NotFound::new);
        return issue;
    }
}
