package kr.codesquad.issuetracker09.web.login.controller;

import kr.codesquad.issuetracker09.domain.User;
import kr.codesquad.issuetracker09.service.JwtService;
import kr.codesquad.issuetracker09.service.OAuthService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import javax.websocket.server.PathParam;
import javax.xml.ws.Response;
import java.io.IOException;

@RestController
public class LoginController {
    private static final Logger log = LoggerFactory.getLogger(LoginController.class);

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

    @PostMapping("/applelogin")
    public ResponseEntity<String> appleLogin(@RequestBody User user) {
        log.debug("[*] Apple user info : {}", user);
        String jwt = "test";
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.setBearerAuth(jwt);
        return ResponseEntity.ok()
                .headers(responseHeaders)
                .body("logined");
    }
}
