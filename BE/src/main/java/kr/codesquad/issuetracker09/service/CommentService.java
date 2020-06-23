package kr.codesquad.issuetracker09.service;

import kr.codesquad.issuetracker09.domain.Comment;
import kr.codesquad.issuetracker09.domain.Issue;
import kr.codesquad.issuetracker09.domain.IssueRepository;
import kr.codesquad.issuetracker09.domain.User;
import kr.codesquad.issuetracker09.exception.ValidationException;
import kr.codesquad.issuetracker09.web.comment.dto.PostRequestDTO;
import lombok.extern.slf4j.Slf4j;
import org.omg.CosNaming.NamingContextPackage.NotFound;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.List;

@Slf4j
@Transactional
@Service
public class CommentService {

    private IssueRepository issueRepository;
    private UserService userService;

    public CommentService(IssueRepository issueRepository, UserService userService) {
        this.issueRepository = issueRepository;
        this.userService = userService;
    }

    public void save(Long issueId, Long authorId, PostRequestDTO commentDTO) throws NotFound {
        Issue issue = issueRepository.findById(issueId).orElseThrow(NotFound::new);
        if (commentDTO.getContents() == null) {
            throw new ValidationException("Contents can't be blank");
        }
        User user = userService.findUser(authorId);
        log.debug("[*] user : {}", user);
        issue.addComment(user, commentDTO);
        issueRepository.save(issue);
    }

    public void edit(Long issueId, Long authorId, Long commentId, PostRequestDTO commentDTO) throws NotFound {
        Issue issue = issueRepository.findById(issueId).orElseThrow(NotFound::new);
        if (commentDTO.getContents() == null) {
            throw new ValidationException("Contents can't be blank");
        }
        List<Comment> commentList = issue.getComments();

        for (Comment comment : commentList) {

            if (comment.getId().equals(commentId)) {
                comment.setContents(commentDTO.getContents());
                comment.setCreated(LocalDateTime.now());
                break;
            }
        }
        issueRepository.save(issue);
    }
}
