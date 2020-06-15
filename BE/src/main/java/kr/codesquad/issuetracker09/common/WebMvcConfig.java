package kr.codesquad.issuetracker09.common;

import kr.codesquad.issuetracker09.service.JwtService;
import kr.codesquad.issuetracker09.service.UserService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    JwtService jwtService;
    UserService userService;

    public WebMvcConfig(JwtService jwtService, UserService userService) {
        this.jwtService = jwtService;
        this.userService = userService;
    }

    @Bean
    public AuthCheckInterceptor authCheckInterceptor() {
        return new AuthCheckInterceptor(jwtService, userService);
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(authCheckInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns("/githublogin")
                .excludePathPatterns("/applelogin");
    }

}
