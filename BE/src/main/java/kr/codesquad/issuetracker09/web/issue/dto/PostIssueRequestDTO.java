package kr.codesquad.issuetracker09.web.issue.dto;

import java.time.LocalDate;

public class PostIssueRequestDTO {
    private String title;
    private String contents;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public static class Builder {
        private String title;
        private String contents;
        private LocalDate dueOn;

        public Builder title(String val) {
            title = val;
            return this;
        }

        public Builder contents(String val) {
            contents = val;
            return this;
        }

        public PostIssueRequestDTO build() {
            return new PostIssueRequestDTO(this);
        }
    }

    private PostIssueRequestDTO(Builder builder) {
        title = builder.title;
        contents = builder.contents;
    }

    public PostIssueRequestDTO() {}

    public PostIssueRequestDTO(String title, String contents) {
        this.title = title;
        this.contents = contents;
    }

    @Override
    public String toString() {
        return "PostRequestDTO{" +
                "title='" + title + '\'' +
                ", contents='" + contents + '\'' +
                '}';
    }
}
