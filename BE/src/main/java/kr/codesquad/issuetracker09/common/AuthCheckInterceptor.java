package kr.codesquad.issuetracker09.common;

import kr.codesquad.issuetracker09.domain.User;
import kr.codesquad.issuetracker09.domain.UserRepository;
import kr.codesquad.issuetracker09.exception.AuthorizationException;
import kr.codesquad.issuetracker09.service.JwtService;
import kr.codesquad.issuetracker09.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.omg.CosNaming.NamingContextPackage.NotFound;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

@Slf4j
public class AuthCheckInterceptor implements HandlerInterceptor {
    private final String HEADER_AUTH = "Authorization";
    private final String LOGIN_TYPE = "LoginType";
    private final JwtService jwtService;
    private final UserService userService;
    private final UserRepository userRepository;

    public AuthCheckInterceptor(JwtService jwtService, UserService userService, UserRepository userRepository) {
        this.jwtService = jwtService;
        this.userService = userService;
        this.userRepository = userRepository;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String loginType = request.getHeader(LOGIN_TYPE);
        String jwt = request.getHeader(HEADER_AUTH);
        if (jwt == null | loginType == null) {
            throw AuthorizationException.emptyToken();
        }
        String socialId;
        if (loginType.equals("github")) {
            socialId = jwtService.parseGithubJwt(jwt).getSocialId();
        } else if (loginType.equals("apple")) {
            Map<String, Object> payloads = jwtService.getTokenPayload(jwt);
            socialId = jwtService.parseAppleJwt(payloads).getSocialId();
        } else {
            throw new AuthorizationException("invalid token");
        }
        User user = userRepository.findUserBySocialId(socialId).orElseThrow(NotFound::new);
        request.setAttribute("id", user.getId());
        return true;
    }
}
