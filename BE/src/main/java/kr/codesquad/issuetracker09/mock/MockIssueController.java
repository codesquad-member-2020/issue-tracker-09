package kr.codesquad.issuetracker09.mock;

import com.fasterxml.jackson.annotation.JsonInclude;
import kr.codesquad.issuetracker09.web.comment.dto.GetCommentListResponseDTO;
import kr.codesquad.issuetracker09.web.issue.dto.*;
import kr.codesquad.issuetracker09.web.label.dto.GetLabelListResponseDTO;
import kr.codesquad.issuetracker09.web.milestone.dto.GetMilestoneListResponseDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@JsonInclude(JsonInclude.Include.NON_NULL)
@RequestMapping("/mock/issues")
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

    @GetMapping()
    public List<GetIssueListResponseDTO> list() {
        List<GetIssueListResponseDTO> getListResponseDTOIssueList = new ArrayList<>();
        GetIssueListResponseDTO getIssueListResponseDTO = GetIssueListResponseDTO.builder()
                .issueId(1L)
                .title("[TEAM] API 논의")
                .contents("### API\n" +
                        "\n" +
                        "- 필요한 API\n" +
                        "- API 포맷\n" +
                        "\n" +
                        "---\n" +
                        "- [HackMD-01](https://hackmd.io/4PN9hfp7T4ihSYCPO4LkLw?edit)")
                .build();
        List<GetLabelListResponseDTO> labels = new ArrayList<>();
        labels.add(GetLabelListResponseDTO.builder()
                .title("iOS")
                .colorCode("#74d10a")
                .build());
        labels.add(GetLabelListResponseDTO.builder()
                .title("BE")
                .colorCode("#008672")
                .build());
        GetMilestoneListResponseDTO milestone = GetMilestoneListResponseDTO.builder().title("1 week").build();
        getIssueListResponseDTO.setMilestone(milestone);
        getIssueListResponseDTO.setLabels(labels);
        getListResponseDTOIssueList.add(getIssueListResponseDTO);
        return getListResponseDTOIssueList;
    }

    @GetMapping("/filter")
    public List<GetIssueListResponseDTO> list(FilterDTO filterDTO) {
        log.debug("[*] filter : {}", filterDTO);

        List<GetIssueListResponseDTO> getIssueListResponseDTOList = new ArrayList<>();
        GetIssueListResponseDTO getIssueListResponseDTO = GetIssueListResponseDTO.builder()
                .issueId(1L)
                .title("[TEAM] API 논의")
                .contents("### API\n" +
                        "\n" +
                        "- 필요한 API\n" +
                        "- API 포맷\n" +
                        "\n" +
                        "---\n" +
                        "- [HackMD-01](https://hackmd.io/4PN9hfp7T4ihSYCPO4LkLw?edit)")
                .build();
        List<GetLabelListResponseDTO> labels = new ArrayList<>();
        labels.add(GetLabelListResponseDTO.builder()
                .title("iOS")
                .colorCode("#74d10a")
                .build());
        labels.add(GetLabelListResponseDTO.builder()
                .title("BE")
                .colorCode("#008672")
                .build());
        GetMilestoneListResponseDTO milestone = GetMilestoneListResponseDTO.builder().title("1 week").build();
        getIssueListResponseDTO.setMilestone(milestone);
        getIssueListResponseDTO.setLabels(labels);
        getIssueListResponseDTOList.add(getIssueListResponseDTO);
        return getIssueListResponseDTOList;
    }

    @GetMapping("/{issue-id}/comments")
    public List<GetCommentListResponseDTO> list(@PathVariable(name = "issue-id") long issueId) {
        List<GetCommentListResponseDTO> getCommentListResponseDTO = new ArrayList<>();
        getCommentListResponseDTO.add(GetCommentListResponseDTO.builder()
                .id(1L)
                .author("poogle")
                .contents("댓글 테스트1")
                .created(LocalDate.parse("2020-06-20"))
                .build());
        getCommentListResponseDTO.add(GetCommentListResponseDTO.builder()
                .id(2L)
                .author("solar")
                .contents("댓글 테스트2")
                .created(LocalDate.parse("2020-06-21"))
                .build());
        return getCommentListResponseDTO;
    }

    @PostMapping("/{issue-id}/comments")
    public void create(@PathVariable(name = "issue-id") long issueId, @RequestBody PostRequestDTO request, HttpServletResponse response) {
        log.debug("[*] create - issueId : {}, request : {}", issueId, request);
        response.setStatus(HttpStatus.OK.value());
    }

    @PutMapping("/{issue-id}/comments/{comment-id}")
    public void edit(@PathVariable(name = "issue-id") long issueId, @PathVariable(name = "comment-id") long commentId, @RequestBody PostRequestDTO request, HttpServletResponse response) {
        log.debug("[*] edit - issueId : {}, commentId : {}, request : {}", commentId, issueId, request);
        response.setStatus(HttpStatus.OK.value());
    }

    @DeleteMapping("/{issue-id}/comments/{comment-id}")
    public void edit(@PathVariable(name = "issue-id") long issueId, @PathVariable(name = "comment-id") long commentId, HttpServletResponse response) {
        log.debug("[*] delete - issueId : {}, commentId : {}", commentId, issueId);
        response.setStatus(HttpStatus.OK.value());
    }
}
