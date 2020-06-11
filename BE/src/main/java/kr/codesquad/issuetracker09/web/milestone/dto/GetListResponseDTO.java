package kr.codesquad.issuetracker09.web.milestone.dto;

import java.time.LocalDate;

public class GetListResponseDTO {
    private Long id;
    private String title;
    private String contents;
    private LocalDate dueOn;
    private Integer numberOfOpenIssue;
    private Integer numberOfClosedIssue;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

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

    public LocalDate getDueOn() {
        return dueOn;
    }

    public void setDueOn(LocalDate dueOn) {
        this.dueOn = dueOn;
    }

    public Integer getNumberOfOpenIssue() {
        return numberOfOpenIssue;
    }

    public void setNumberOfOpenIssue(Integer numberOfOpenIssue) {
        this.numberOfOpenIssue = numberOfOpenIssue;
    }

    public Integer getNumberOfClosedIssue() {
        return numberOfClosedIssue;
    }

    public void setNumberOfClosedIssue(Integer numberOfClosedIssue) {
        this.numberOfClosedIssue = numberOfClosedIssue;
    }

    public static class Builder {
        private Long id;
        private String title;
        private String contents;
        private LocalDate dueOn;
        private Integer numberOfOpenIssue;
        private Integer numberOfClosedIssue;

        public Builder() {}

        public Builder id(Long val) {
            id = val;
            return this;
        }

        public Builder title(String val) {
            title = val;
            return this;
        }

        public Builder contents(String val) {
            contents = val;
            return this;
        }

        public Builder dueOn(LocalDate val) {
            dueOn = val;
            return this;
        }

        public Builder numberOfOpenIssue(Integer val) {
            numberOfOpenIssue = val;
            return this;
        }

        public Builder numberOfClosedIssue(Integer val) {
            numberOfClosedIssue = val;
            return this;
        }

        public GetListResponseDTO build() {
            return new GetListResponseDTO(this);
        }
    }

    private GetListResponseDTO(Builder builder) {
        id = builder.id;
        title = builder.title;
        contents = builder.title;
        dueOn = builder.dueOn;
        numberOfOpenIssue = builder.numberOfOpenIssue;
        numberOfClosedIssue = builder.numberOfClosedIssue;
    }
}
