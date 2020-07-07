package kr.codesquad.issuetracker09.web.milestone.controller;

import kr.codesquad.issuetracker09.domain.Milestone;
import kr.codesquad.issuetracker09.exception.NotFoundException;
import kr.codesquad.issuetracker09.service.MilestoneService;
import kr.codesquad.issuetracker09.web.milestone.dto.MilestoneListDTO;
import kr.codesquad.issuetracker09.web.milestone.dto.MilestonePickerDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Optional;

@Slf4j
@RequestMapping("/milestones")
@RestController
public class MilestoneController {

    private MilestoneService milestoneService;

    public MilestoneController(MilestoneService milestoneService) {
        this.milestoneService = milestoneService;
    }

    @GetMapping()
    public List<MilestoneListDTO> getAllMilestones() {
        return milestoneService.findAll();
    }

    @PostMapping()
    public void create(@RequestBody Milestone milestone, HttpServletResponse response) {
        log.debug("[*] create - milestone : {}", milestone);
        milestoneService.save(milestone);
        response.setStatus(HttpStatus.CREATED.value());
    }

    @PutMapping("/{milestone-id}")
    public void edit(@PathVariable(name = "milestone-id") Long milestoneId, @RequestBody Milestone milestone, HttpServletResponse response) {
        log.debug("[*] edit - milestoneId: {}", milestone);
        Milestone originMileStone = milestoneService.findById(milestoneId);
        originMileStone.setTitle(milestone.getTitle());
        originMileStone.setContents(milestone.getContents());
        originMileStone.setDueOn(milestone.getDueOn());
        milestoneService.save(originMileStone);
        response.setStatus(HttpStatus.NO_CONTENT.value());
    }

    @DeleteMapping("/{milestone-id}")
    public void delete(@PathVariable(name = "milestone-id") Long milestoneId, HttpServletResponse response) {
        log.debug("[*] delete - milestoneId: {}", milestoneId);
        milestoneService.delete(milestoneId);
        response.setStatus(HttpStatus.NO_CONTENT.value());
    }

    @GetMapping("/picker")
    public List<MilestonePickerDTO> picker() {
        return milestoneService.findAllPicker();
    }
}
