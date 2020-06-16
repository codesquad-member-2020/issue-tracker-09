package kr.codesquad.issuetracker09.web.label.controller;

import kr.codesquad.issuetracker09.domain.Label;
import kr.codesquad.issuetracker09.service.LabelService;
import kr.codesquad.issuetracker09.web.label.dto.PostRequestDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

@RequestMapping("/labels")
@RestController
public class LabelController {
    private static final Logger log = LoggerFactory.getLogger(LabelController.class);

    private LabelService labelService;

    public LabelController(LabelService labelService) {
        this.labelService = labelService;
    }

    @GetMapping()
    public List<Label> getAllLabels() {
        return labelService.findAll();
    }

    @PostMapping()
    public void create(@RequestBody Label label, HttpServletResponse response) {
        log.debug("[*] create - label : {}", label);
        labelService.save(label);
        response.setStatus(HttpStatus.CREATED.value());
    }
}
