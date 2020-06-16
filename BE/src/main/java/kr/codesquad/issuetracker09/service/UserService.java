package kr.codesquad.issuetracker09.service;

import kr.codesquad.issuetracker09.data.UserRepository;
import kr.codesquad.issuetracker09.domain.User;
import kr.codesquad.issuetracker09.exception.NotFoundException;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
public class UserService {

    private final JwtService jwtService;
    private final UserRepository userRepository;

    public UserService(JwtService jwtService, UserRepository userRepository) {
        this.jwtService = jwtService;
        this.userRepository = userRepository;
    }

    public User findUser(Long id) {
        return userRepository.findById(id).orElseThrow(() -> new NotFoundException("사용자를 찾을 수 없습니다."));
    }

    @Transactional
    public void insertOrUpdateUser(User user) {
        if (userRepository.findUserBySocialId(user.getSocialId()).orElse(null) == null) {
            User newUser = User.insert(user.getId(), user.getName(), user.getSocialId(), user.getEmail());
            userRepository.save(newUser);
        }
    }
}
