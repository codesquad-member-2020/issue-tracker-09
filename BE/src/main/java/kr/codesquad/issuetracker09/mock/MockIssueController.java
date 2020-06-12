package kr.codesquad.issuetracker09.mock;

import com.fasterxml.jackson.annotation.JsonInclude;
import kr.codesquad.issuetracker09.web.issue.dto.PatchCloseIssueRequestDTO;
import kr.codesquad.issuetracker09.web.issue.dto.PatchDetailRequestDTO;
import kr.codesquad.issuetracker09.web.issue.dto.PostRequestDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.List;

@JsonInclude(JsonInclude.Include.NON_NULL)
@RequestMapping("/mock/issue")
@RestController
public class MockIssueController {
    private static final Logger log = LoggerFactory.getLogger(MockIssueController.class);

    @PostMapping
    public void create(@RequestBody PostRequestDTO request, HttpServletResponse response) {
        log.debug("[*] create - request : {}", request);
        response.setStatus(HttpStatus.OK.value());
    }

    @PutMapping("/{issue-id}")
    public void edit(@PathVariable(name = "issue-id") long issueId,
            @RequestBody PostRequestDTO request, HttpServletResponse response) {
        log.debug("[*] patch - issueId : {}, request : {}", issueId, request);
        response.setStatus(HttpStatus.OK.value());
    }

    @PatchMapping("/{issue-id}/detail")
    public void patchDeatil(@PathVariable(name = "issue-id") long issueId,
                            @RequestBody PatchDetailRequestDTO request,
                            HttpServletResponse response) {
        log.debug("[*] put - issueId : {}, request : {}", issueId, request);
        response.setStatus(HttpStatus.OK.value());
    }

    @PatchMapping()
    public void closeIssue(@RequestBody PatchCloseIssueRequestDTO request, HttpServletResponse response) {
        log.debug("[*] closeIssue - request : {}", request);
        response.setStatus(HttpStatus.OK.value());
    }

}
