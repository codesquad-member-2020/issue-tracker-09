package kr.codesquad.issuetracker09.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import kr.codesquad.issuetracker09.domain.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Service
public class JwtService {

    private final String JWT_KEY;
    private final String APPLE_KEY;
    private final String APPLE_ID;
    private SecretKey key;

    public JwtService(Environment env) {
        JWT_KEY = env.getProperty("JWT_KEY");
        APPLE_KEY = env.getProperty("APPLE_KEY");
        APPLE_ID = env.getProperty("APPLE_ID");
        key = Keys.hmacShaKeyFor(JWT_KEY.getBytes());
    }

    public String buildJwt(User user) {
        return Jwts.builder()
                .setHeader(createHeaders())
                .setClaims(createPayloads(user))
                .signWith(key, SignatureAlgorithm.HS256)
                .compact();
    }

    public User parseJwt(String jwt) {
        jwt = jwt.replace("Bearer ", "");
        Claims claims = Jwts.parserBuilder()
                .setSigningKey(key)
                .build()
                .parseClaimsJws(jwt)
                .getBody();
        Long id = claims.get("id", Long.class);
        String name = (String) claims.get("name");
        log.debug("[*] name: {}", name);
        String socialId = (String) claims.get("socialId");
        log.debug("[*] socialId: {}", socialId);
        String email = (String) claims.get("email");
        return User.builder()
                .id(id)
                .name(name)
                .socialId(socialId)
                .email(email)
                .build();
    }

    private Map<String, Object> createHeaders() {
        Map<String, Object> headers = new HashMap<>();
        headers.put("typ", "JWT");
        headers.put("alg", "HS256");
        return headers;
    }

    private Map<String, Object> createPayloads(User user) {
        Map<String, Object> payloads = new HashMap<>();
        payloads.put("id", user.getId());
        payloads.put("name", user.getName());
        payloads.put("socialId", user.getSocialId());
        payloads.put("email", user.getEmail());
        return payloads;
    }

    public boolean checkAppleValidation(Map<String, Object> payloads) {
        String registeredKey = (String) payloads.get("iss");
        String account = (String) payloads.get("aud");
        log.debug("[*] keyCheck: {}", registeredKey.equals(APPLE_KEY));
        log.debug("[*] idCheck: {}", account.equals(APPLE_ID));
        return (registeredKey.equals(APPLE_KEY) && account.equals(APPLE_ID));
    }

    public Map<String, Object> getTokenPayload(String jwt) {
        Map<String, Object> payloadMap = new HashMap<>();
        ObjectMapper om = new ObjectMapper();
        String encodedTokenPayload = jwt.split("\\.")[1];
        Base64.Decoder decoder = Base64.getDecoder();
        String tokenPayload = new String(decoder.decode(encodedTokenPayload));
        try {
            payloadMap = om.readValue(tokenPayload, new TypeReference<Map<String, Object>>() {
            });
        } catch (Exception e) {
            System.out.println("[getTokenPayload] + " + e.getMessage());
        }
        return payloadMap;
    }

    public User parseAppleJwt(Map<String, Object> payloads) {
        log.debug("[*] claims: {}", payloads);
        String socialId = (String) payloads.get("sub");
        log.debug("[*] socialId: {}", socialId);
        String email = (String) payloads.get("email");
        log.debug("[*] email: {}", email);
        String name = email.substring(0, email.indexOf("@"));
        log.debug("[*] name: {}", name);
        return User.builder()
                .name(name)
                .socialId(socialId)
                .email(email)
                .build();
    }
}
