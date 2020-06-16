package kr.codesquad.issuetracker09.web.label.controller;

import kr.codesquad.issuetracker09.domain.Label;
import kr.codesquad.issuetracker09.service.LabelService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
}
