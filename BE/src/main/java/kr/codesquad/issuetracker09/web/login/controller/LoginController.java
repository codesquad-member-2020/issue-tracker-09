package kr.codesquad.issuetracker09.web.login.controller;

import kr.codesquad.issuetracker09.domain.User;
import kr.codesquad.issuetracker09.service.JwtService;
import kr.codesquad.issuetracker09.service.OAuthService;
import kr.codesquad.issuetracker09.service.UserService;
import kr.codesquad.issuetracker09.web.login.dto.PostRequestDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import javax.websocket.server.PathParam;
import java.io.IOException;
import java.util.Map;

@RestController
public class LoginController {
    private static final Logger log = LoggerFactory.getLogger(LoginController.class);

    private final JwtService jwtService;
    private final OAuthService oAuthService;
    private final UserService userService;

    public LoginController(JwtService jwtService, OAuthService oAuthService, UserService userService) {
        this.jwtService = jwtService;
        this.oAuthService = oAuthService;
        this.userService = userService;
    }

    @GetMapping("/githublogin")
    public ResponseEntity<String> githubLogin(@PathParam("code") String code, HttpServletResponse response) throws IOException {
        User user = oAuthService.getSocialUser(code);
        userService.insertOrUpdateUser(user);
        String jwt = jwtService.buildJwt(user);
        response.sendRedirect("issuenine://oauth?token=" + jwt);
        return ResponseEntity.status(HttpStatus.TEMPORARY_REDIRECT).body("redirect");
    }

    @PostMapping("/applelogin")
    public void appleLogin(@RequestBody PostRequestDTO postRequestDTO, HttpServletResponse response) {
        Map<String, Object> payloads = jwtService.getTokenPayload(postRequestDTO.getJwtToken());
        if (!jwtService.checkAppleValidation(payloads)) {
            response.setStatus(HttpStatus.UNAUTHORIZED.value());
            return;
        }
        User user = jwtService.parseAppleJwt(payloads);
        log.debug("[*] user : {}", user);
        userService.insertOrUpdateUser(user);
        response.setStatus(HttpStatus.OK.value());
    }
}
