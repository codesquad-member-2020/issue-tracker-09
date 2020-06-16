package kr.codesquad.issuetracker09.service;

import kr.codesquad.issuetracker09.domain.Label;
import kr.codesquad.issuetracker09.domain.LabelRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class LabelService {
    private LabelRepository labelRepository;

    public LabelService(LabelRepository labelRepository) {
        this.labelRepository = labelRepository;
    }

    public List<Label> findAll() {
        List<Label> labels = new ArrayList<>();
        labelRepository.findAll().forEach(e -> labels.add(e));
        return labels;
    }

    public Label save(Label label) {
        return labelRepository.save(label);
    }
}
