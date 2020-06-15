package kr.codesquad.issuetracker09.common;

import kr.codesquad.issuetracker09.domain.User;
import kr.codesquad.issuetracker09.exception.AuthorizationException;
import kr.codesquad.issuetracker09.service.JwtService;
import kr.codesquad.issuetracker09.service.UserService;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AuthCheckInterceptor implements HandlerInterceptor {
    private final String HEADER_AUTH = "Authorization";
    private final JwtService jwtService;
    private final UserService userService;

    public AuthCheckInterceptor(JwtService jwtService, UserService userService) {
        this.jwtService = jwtService;
        this.userService = userService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String jwt = request.getHeader(HEADER_AUTH);

        if (jwt != null) {
            User user = jwtService.parseJwt(jwt);
            request.setAttribute("id", user.getId());
        } else {
            throw AuthorizationException.emptyToken();
        }
        return true;
    }
}
