package kr.codesquad.issuetracker09.web.milestone.controller;

import kr.codesquad.issuetracker09.domain.Milestone;
import kr.codesquad.issuetracker09.service.MilestoneService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RequestMapping("/milestones")
@RestController
public class MilestoneController {

    private MilestoneService milestoneService;

    public MilestoneController(MilestoneService milestoneService) {
        this.milestoneService = milestoneService;
    }

    @GetMapping()
    public List<Milestone> getAllMilestones() {
        return milestoneService.findAll();
    }
}
