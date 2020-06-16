package kr.codesquad.issuetracker09.service;

import kr.codesquad.issuetracker09.domain.UserRepository;
import kr.codesquad.issuetracker09.domain.User;
import kr.codesquad.issuetracker09.exception.NotFoundException;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    private final JwtService jwtService;
    private final UserRepository userRepository;

    public UserService(JwtService jwtService, UserRepository userRepository) {
        this.jwtService = jwtService;
        this.userRepository = userRepository;
    }

    public List<User> findAll() {
        List<User> users = new ArrayList<>(userRepository.findAll());
        return users;
    }

    public User findUser(Long id) {
        return userRepository.findById(id).orElseThrow(() -> new NotFoundException("사용자를 찾을 수 없습니다."));
    }

    @Transactional
    public void insertOrUpdateUser(User user) {
        Optional<User> currentUser = userRepository.findUserBySocialId(user.getSocialId());
        if (currentUser.isPresent()) {
            currentUser.get().setName(user.getName());
            currentUser.get().setEmail(user.getEmail());
            userRepository.save(currentUser.get());
        } else {
            userRepository.save(user);
        }
    }
}
