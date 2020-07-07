package kr.codesquad.issuetracker09.domain;

import org.hibernate.annotations.SQLDelete;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IssueHasLabelRepository extends JpaRepository<IssueHasLabel, Long> {

    @Query(value = "SELECT label FROM IssueHasLabel WHERE issue_id = :id")
    List<Label> findLabelByIssueId(@Param("id") Long issueId);

    @SQLDelete(sql = "DELETE FROM issue_has_label WHERE label_id = :id")
    void deleteByLabelId(@Param("id") Long labelId);

    @SQLDelete(sql = "DELETE FROM issue_has_label WHERE issue_id = :id")
    void deleteByIssueId(@Param("id") Long issueId);

    @Query(value = "SELECT issue_id FROM issue_has_label WHERE label_id IN (:id) GROUP BY issue_id HAVING count(issue_id) = :count", nativeQuery=true)
    List<Long> findIssueIdsInLabelIds(@Param("id") List<Long> labelIds, @Param("count") Long count);
}
