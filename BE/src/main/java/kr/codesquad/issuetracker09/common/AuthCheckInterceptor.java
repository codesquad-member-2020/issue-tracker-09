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

@Slf4j
public class AuthCheckInterceptor implements HandlerInterceptor {
    private final String HEADER_AUTH = "Authorization";
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
        String jwt = request.getHeader(HEADER_AUTH);

        if (jwt != null) {
            String socialId = jwtService.parseJwt(jwt).getSocialId();
            log.debug("[*] socialId : {}", socialId);
            User user = userRepository.findUserBySocialId(socialId).orElseThrow(NotFound::new);
            log.debug("[*] user : {}", user);
            log.debug("[*] userId : {}", user.getId());
            request.setAttribute("id", user.getId());
        } else {
            throw AuthorizationException.emptyToken();
        }
        return true;
    }
}
