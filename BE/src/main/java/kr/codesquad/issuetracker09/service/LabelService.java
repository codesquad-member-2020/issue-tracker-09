package kr.codesquad.issuetracker09.service;

import kr.codesquad.issuetracker09.domain.IssueHasLabelRepository;
import kr.codesquad.issuetracker09.domain.Label;
import kr.codesquad.issuetracker09.domain.LabelRepository;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class LabelService {
    private LabelRepository labelRepository;
    private IssueHasLabelRepository issueHasLabelRepository;

    public LabelService(LabelRepository labelRepository, IssueHasLabelRepository issueHasLabelRepository) {
        this.labelRepository = labelRepository;
        this.issueHasLabelRepository = issueHasLabelRepository;
    }

    public List<Label> findAll() {
        List<Label> labels = new ArrayList<>(labelRepository.findAll());
        return labels;
    }

    public Label save(Label label) {
        return labelRepository.save(label);
    }

    public Optional<Label> findById(Long id) {
        return labelRepository.findById(id);
    }

    @Transactional
    public void delete(Long id) {
        issueHasLabelRepository.deleteByLabelId(id);
        labelRepository.deleteById(id);
    }
}
