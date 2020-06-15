package kr.codesquad.issuetracker09.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import kr.codesquad.issuetracker09.domain.GithubToken;
import kr.codesquad.issuetracker09.domain.User;
import org.springframework.core.env.Environment;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@Service
public class OAuthService {

    private final ObjectMapper objectMapper;
    private final String ACCESS_TOKEN_URL = "https://github.com/login/oauth/access_token";
    private final String USER_DATA_API = "https://api.github.com/user";
    private final String CLIENT_ID;
    private final String CLIENT_SECRET;

    public OAuthService(ObjectMapper objectMapper, Environment env) {
        this.objectMapper = objectMapper;
        CLIENT_ID = env.getProperty("CLIENT_ID");
        CLIENT_SECRET = env.getProperty("CLIENT_SECRET");
    }

    public GithubToken getAccessToken(String code) {
        MultiValueMap<String ,String> headers = new LinkedMultiValueMap<>();
        Map<String, String> header = new HashMap<>();
        header.put("Accept", "application/json");
        headers.setAll(header);

        MultiValueMap<String, String> requestPayloads = new LinkedMultiValueMap<>();
        Map<String, String> requestPayload = new HashMap<>();
        requestPayload.put("client_id", CLIENT_ID);
        requestPayload.put("client_secret", CLIENT_SECRET);
        requestPayload.put("code", code);
        requestPayloads.setAll(requestPayload);
        HttpEntity<?> request = new HttpEntity<>(requestPayloads, headers);
        ResponseEntity<?> response = new RestTemplate().postForEntity(ACCESS_TOKEN_URL, request, GithubToken.class);
        return (GithubToken) response.getBody();
    }

    public User getSocialUser(String code) throws JsonProcessingException {
        GithubToken accessToken = getAccessToken(code);
        ResponseEntity<String> response = new RestTemplate().exchange(USER_DATA_API, HttpMethod.GET,
                getHttpEntityWithAuthorization(accessToken), String.class);

        if (response.getStatusCode() == HttpStatus.OK) {
            JsonNode jsonNode = objectMapper.readTree(response.getBody());
            return User.builder()
                    .socialId(jsonNode.required("id").asLong())
                    .name(jsonNode.required("name").asText())
                    .email(jsonNode.required("email").asText())
                    .build();
        }

        return null;
    }

    private HttpEntity<String> getHttpEntityWithAuthorization(GithubToken githubToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(githubToken.getAccessToken());
        return new HttpEntity<>(headers);
    }
}
