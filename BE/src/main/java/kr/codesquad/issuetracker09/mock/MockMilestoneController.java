package kr.codesquad.issuetracker09.mock;

import kr.codesquad.issuetracker09.web.milestone.dto.GetListResponseDTO;
import kr.codesquad.issuetracker09.web.milestone.dto.PostRequestDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@RequestMapping("/mock/milestone")
@RestController
public class MockMilestoneController {
    private static final Logger log = LoggerFactory.getLogger(MockMilestoneController.class);
    
    @GetMapping()
    public List<GetListResponseDTO> list() {
        List<GetListResponseDTO> getListResponseDTOList = new ArrayList<>();
        getListResponseDTOList.add(new GetListResponseDTO.Builder()
                .id(1L)
                .title("1 WEEK")
                .contents("1주차 목표입니다.")
                .dueOn(LocalDate.parse("2020-06-13"))
                .numberOfOpenIssue(5)
                .numberOfClosedIssue(6)
                .build());
        getListResponseDTOList.add(new GetListResponseDTO.Builder()
                .id(2L)
                .title("2 WEEK")
                .contents("2주차 목표입니다.")
                .dueOn(LocalDate.parse("2020-06-20"))
                .numberOfOpenIssue(11)
                .numberOfClosedIssue(1)
                .build());

        return getListResponseDTOList;
    }

    @PostMapping()
    public void create(@RequestBody PostRequestDTO request, HttpServletResponse response) {
        log.debug("[*] request : {}", request);
        response.setStatus(HttpStatus.OK.value());
    }

    @PutMapping("/{issueId}")
    public void edit(@PathVariable long issueId, @RequestBody PostRequestDTO request, HttpServletResponse response) {
        log.debug("[*] issueId : {}, request : {}", issueId, request);
        response.setStatus(HttpStatus.OK.value());
    }
}
