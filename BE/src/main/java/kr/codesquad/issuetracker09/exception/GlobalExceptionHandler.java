package kr.codesquad.issuetracker09.exception;

import io.jsonwebtoken.JwtException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler({JwtException.class, AuthorizationException.class})
    public ResponseEntity<String> handleAuthorizationException(RuntimeException e) {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body("invalid token");
    }

    @ExceptionHandler(ValidationException.class)
    public ResponseEntity<String> handlerValidationException(ValidationException e) {
        return ResponseEntity.status(HttpStatus.UNPROCESSABLE_ENTITY)
                .body(e.getMessage());
    }
}
