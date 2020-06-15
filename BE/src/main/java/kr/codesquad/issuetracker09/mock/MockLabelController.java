package kr.codesquad.issuetracker09.mock;
import kr.codesquad.issuetracker09.web.label.dto.GetLabelListResponseDTO;
import kr.codesquad.issuetracker09.web.label.dto.PostRequestDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@RequestMapping("/mock/labels")
@RestController
public class MockLabelController {
    @GetMapping()
    public List<GetLabelListResponseDTO> list() {
        List<GetLabelListResponseDTO> getListResponseDTOLabelList = new ArrayList<>();
        getListResponseDTOLabelList.add(GetLabelListResponseDTO.builder()
                .id(1L)
                .title("BE")
                .contents("BE 개발")
                .colorCode("#008672")
                .build());
        getListResponseDTOLabelList.add(GetLabelListResponseDTO.builder()
                .id(2L)
                .title("iOS")
                .contents("iOS 개발")
                .colorCode("#74d10a")
                .build());
        return getListResponseDTOLabelList;
    }

    @PostMapping()
    public void create(@RequestBody PostRequestDTO request, HttpServletResponse response) {
        log.debug("[*] create - request : {}", request);
        response.setStatus(HttpStatus.OK.value());
    }

    @PutMapping("/{label-id}")
    public void edit(@PathVariable(name = "label-id") long labelId, @RequestBody PostRequestDTO request, HttpServletResponse response) {
        log.debug("[*] edit - labelId : {}, request : {}", labelId, request);
        response.setStatus(HttpStatus.OK.value());
    }

    @DeleteMapping("/{label-id}")
    public void delete(@PathVariable(name = "label-id") long labelId, HttpServletResponse response) {
        log.debug("[*] delete - labelId: {}", labelId);
        response.setStatus(HttpStatus.OK.value());
    }
}
