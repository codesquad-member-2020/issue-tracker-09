package kr.codesquad.issuetracker09.web.user.controller;

import kr.codesquad.issuetracker09.domain.User;
import kr.codesquad.issuetracker09.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequestMapping("/users")
@RestController
public class UserController {

    private UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping()
    public List<User> list() {
        List<User> userList = userService.findAll();
        return userList;
    }
}
