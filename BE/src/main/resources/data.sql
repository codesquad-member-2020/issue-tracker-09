INSERT INTO user (social_id, name, email)
VALUES (123123, 'Solar', 'solar@gmail.com');
INSERT INTO user (social_id, name, email)
VALUES (321321, 'Poogle', 'poogle@gmail.com');

INSERT INTO label (title, color_code)
VALUES ("TEAM", "#123aaa");
INSERT INTO label (title, contents, color_code)
VALUES ("BE", "BE develop", "#008672");
INSERT INTO label (title, contents, color_code)
VALUES ("iOS", "iOS develop", "#74d10a");

INSERT INTO milestone (title, contents, due_on)
VALUES ("1 WEEK", "1 WEEK PLAN", "2020-06-12");
INSERT INTO milestone (title, contents, due_on)
VALUES ("2 WEEK", "2 WEEK PLAN", "2020-06-19");
INSERT INTO milestone (title, contents, due_on)
VALUES ("3 WEEK", "3 WEEK PLAN", "2020-06-26");

INSERT INTO issue (title, contents, created, open, is_deleted, user_id, milestone_id)
VALUES ("issue 1", "first issue blabla", "2020-06-18", TRUE, FALSE, 1, 1);
INSERT INTO issue (title, contents, created, open, is_deleted, user_id, milestone_id)
VALUES ("issue 2", "second issue blabla", "2020-06-18", TRUE, FALSE, 2, 2);

INSERT INTO comment (contents, user_id, created, issue_id)
VALUES ("Good!!", 2, "2020-06-19 13:01:23", 1);
INSERT INTO comment (contents, user_id, created, issue_id)
VALUES ("OKOK!!", 1, "2020-06-19 13:21:34", 1);
INSERT INTO comment (contents, user_id, created, issue_id)
VALUES ("Hi!!", 2, "2020-06-19 13:34:11", 1);

INSERT INTO issue_has_label (issue_id, label_id) VALUES (1, 1);
INSERT INTO issue_has_label (issue_id, label_id) VALUES (1, 2);
INSERT INTO issue_has_label (issue_id, label_id) VALUES (1, 3);
INSERT INTO issue_has_label (issue_id, label_id) VALUES (2, 2);
INSERT INTO issue_has_label (issue_id, label_id) VALUES (2, 3);
