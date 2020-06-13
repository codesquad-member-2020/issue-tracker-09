package kr.codesquad.issuetracker09.mock;

import com.fasterxml.jackson.annotation.JsonInclude;
import kr.codesquad.issuetracker09.web.issue.dto.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
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

    @GetMapping()
    public List<GetListResponseDTO> list() {
        List<GetListResponseDTO> getListResponseDTOList = new ArrayList<>();
        GetListResponseDTO getListResponseDTO = GetListResponseDTO.builder()
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
        List<kr.codesquad.issuetracker09.web.label.dto.GetListResponseDTO> labels = new ArrayList<>();
        labels.add(kr.codesquad.issuetracker09.web.label.dto.GetListResponseDTO.builder()
                .title("iOS")
                .colorCode("#74d10a")
                .build());
        labels.add(kr.codesquad.issuetracker09.web.label.dto.GetListResponseDTO.builder()
                .title("BE")
                .colorCode("#008672")
                .build());
        kr.codesquad.issuetracker09.web.milestone.dto.GetListResponseDTO milestone = new kr.codesquad.issuetracker09.web.milestone.dto.GetListResponseDTO
                .Builder().title("1 week").build();
        getListResponseDTO.setMilestone(milestone);
        getListResponseDTO.setLabels(labels);
        getListResponseDTOList.add(getListResponseDTO);
        return getListResponseDTOList;
    }

    @GetMapping("/filter")
    public List<GetListResponseDTO> list(FilterDTO filterDTO) {
        log.debug("[*] filter : {}", filterDTO);

        List<GetListResponseDTO> getListResponseDTOList = new ArrayList<>();
        GetListResponseDTO getListResponseDTO = GetListResponseDTO.builder()
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
        List<kr.codesquad.issuetracker09.web.label.dto.GetListResponseDTO> labels = new ArrayList<>();
        labels.add(kr.codesquad.issuetracker09.web.label.dto.GetListResponseDTO.builder()
                .title("iOS")
                .colorCode("#74d10a")
                .build());
        labels.add(kr.codesquad.issuetracker09.web.label.dto.GetListResponseDTO.builder()
                .title("BE")
                .colorCode("#008672")
                .build());
        kr.codesquad.issuetracker09.web.milestone.dto.GetListResponseDTO milestone = new kr.codesquad.issuetracker09.web.milestone.dto.GetListResponseDTO
                .Builder().title("1 week").build();
        getListResponseDTO.setMilestone(milestone);
        getListResponseDTO.setLabels(labels);
        getListResponseDTOList.add(getListResponseDTO);
        return getListResponseDTOList;
    }
}
