package kr.codesquad.issuetracker09.service;

import kr.codesquad.issuetracker09.domain.Milestone;
import kr.codesquad.issuetracker09.domain.MilestoneRepository;
import kr.codesquad.issuetracker09.exception.ValidationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class MilestoneService {

    private MilestoneRepository milestoneRepository;

    public MilestoneService(MilestoneRepository milestoneRepository) {
        this.milestoneRepository = milestoneRepository;
    }

    public List<Milestone> findAll() {
        List<Milestone> milestones = new ArrayList<>(milestoneRepository.findAll());
        return milestones;
    }

    public Milestone save(Milestone milestone) {
        if (milestone.getTitle() == null) {
            throw new ValidationException("Title can't be blank");
        }
        return milestoneRepository.save(milestone);
    }

    public Optional<Milestone> findById(Long milestoneId) {
        return milestoneRepository.findById(milestoneId);
    }

    public void delete(Long milestoneId) {
        milestoneRepository.deleteById(milestoneId);
    }
}
