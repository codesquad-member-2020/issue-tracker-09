package kr.codesquad.issuetracker09.common;

import kr.codesquad.issuetracker09.domain.UserRepository;
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
    UserRepository userRepository;

    public WebMvcConfig(JwtService jwtService, UserService userService, UserRepository userRepository) {
        this.jwtService = jwtService;
        this.userService = userService;
        this.userRepository = userRepository;
    }

    @Bean
    public AuthCheckInterceptor authCheckInterceptor() {
        return new AuthCheckInterceptor(jwtService, userService, userRepository);
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(authCheckInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns("/githublogin")
                .excludePathPatterns("/applelogin")
                .excludePathPatterns("/mock/**");
    }

}
