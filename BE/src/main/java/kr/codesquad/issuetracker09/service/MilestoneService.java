package kr.codesquad.issuetracker09.service;

import kr.codesquad.issuetracker09.domain.Milestone;
import kr.codesquad.issuetracker09.domain.MilestoneRepository;
import kr.codesquad.issuetracker09.exception.ValidationException;
import kr.codesquad.issuetracker09.web.milestone.dto.MilestonePickerDTO;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Slf4j
@Transactional
@Service
public class MilestoneService {

    private MilestoneRepository milestoneRepository;
    private ModelMapper modelMapper;

    public MilestoneService(MilestoneRepository milestoneRepository, ModelMapper modelMapper) {
        this.milestoneRepository = milestoneRepository;
        this.modelMapper = modelMapper;
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

    public List<MilestonePickerDTO> findAllPicker() {
        List<Milestone> milestones = milestoneRepository.findAll();
        List<MilestonePickerDTO> milestonePickerDTOList = new ArrayList<>();
        for (Milestone milestone : milestones) {
            MilestonePickerDTO milestonePickerDTO = modelMapper.map(milestone, MilestonePickerDTO.class);
            milestonePickerDTOList.add(milestonePickerDTO);
        }
        return milestonePickerDTOList;
    }
}
