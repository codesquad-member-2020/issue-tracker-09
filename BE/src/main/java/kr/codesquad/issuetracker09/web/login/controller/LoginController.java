package kr.codesquad.issuetracker09.web.login.controller;

import kr.codesquad.issuetracker09.domain.User;
import kr.codesquad.issuetracker09.service.JwtService;
import kr.codesquad.issuetracker09.service.OAuthService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import javax.websocket.server.PathParam;
import java.io.IOException;

@RestController
public class LoginController {
    private final JwtService jwtService;
    private final OAuthService oAuthService;

    public LoginController(JwtService jwtService, OAuthService oAuthService) {
        this.jwtService = jwtService;
        this.oAuthService = oAuthService;
    }

    @GetMapping("/githublogin")
    public ResponseEntity<String> githubLogin(@PathParam("code") String code, HttpServletResponse response) throws IOException {
        User user = oAuthService.getSocialUser(code);
        //TODO: insert or update user
        String jwt = jwtService.buildJwt(user);
        response.sendRedirect("issuenine://oauth?token=" + jwt);
        return ResponseEntity.status(HttpStatus.TEMPORARY_REDIRECT).body("redirect");
    }
}
