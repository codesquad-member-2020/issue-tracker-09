package kr.codesquad.issuetracker09.web.label.controller;

import kr.codesquad.issuetracker09.domain.Label;
import kr.codesquad.issuetracker09.service.LabelService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Optional;

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
    public ResponseEntity<Label> create(@RequestBody Label label) {
        log.debug("[*] create - label : {}", label);
        Label createdLabel = labelService.save(label);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(createdLabel);
    }

    @PutMapping("/{label-id}")
    public void edit(@PathVariable(name = "label-id") long labelId, @RequestBody Label label, HttpServletResponse response) {
        log.debug("[*] delete - labelId: {}", labelId);
        Optional<Label> originLabel = labelService.findById(labelId);
        if (originLabel.isPresent()) {
            originLabel.get().setTitle(label.getTitle());
            originLabel.get().setContents(label.getContents());
            originLabel.get().setColorCode(label.getColorCode());
            labelService.save(originLabel.get());
        }
        response.setStatus(HttpStatus.NO_CONTENT.value());
    }

    @DeleteMapping("/{label-id}")
    public void delete(@PathVariable(name = "label-id") long labelId, HttpServletResponse response) {
        log.debug("[*] delete - labelId: {}", labelId);
        labelService.delete(labelId);
        response.setStatus(HttpStatus.NO_CONTENT.value());
    }
}
