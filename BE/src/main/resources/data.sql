INSERT INTO user (social_id, name, email)
VALUES (123123, 'Solar', 'solar@gmail.com');
INSERT INTO user (social_id, name, email)
VALUES (321321, 'sssss', 'ssss@gmail.com');
INSERT INTO user (social_id, name, email)
VALUES (58318786, 'Poogle', null);
INSERT INTO user (social_id, name, email) VALUES (111111, 'Lin', 'lin@gmail.com');
INSERT INTO user (social_id, name, email) VALUES (222222, 'Gangwoon', 'gangwoon@gmail.com');

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
VALUES ("issue 1", "first issue blabla", "2020-06-18 15:21:11", TRUE, FALSE, 1, 1);
INSERT INTO issue (title, contents, created, open, is_deleted, user_id, milestone_id)
VALUES ("issue 2", "second issue blabla", "2020-06-18 13:22:01", TRUE, FALSE, 2, 2);
INSERT INTO issue (title, contents, created, open, is_deleted, user_id, milestone_id)
VALUES ("issue 3", "333 issue blabla", "2020-06-22 05:14:22", FALSE, FALSE, 1, 2);
INSERT INTO issue (title, contents, created, open, is_deleted, user_id, milestone_id)
VALUES ("issue 4", "444 issue blabla", "2020-06-22 06:14:22", TRUE, FALSE, 1, 2);
INSERT INTO issue (title, contents, created, open, is_deleted, user_id, milestone_id)
VALUES ("issue 5", "555 issue blabla", "2020-06-22 05:14:22", TRUE, FALSE, 2, 2);

INSERT INTO comment (contents, user_id, created, issue_id)
VALUES ("Good!!", 2, "2020-06-19 13:01:23", 1);
INSERT INTO comment (contents, user_id, created, issue_id)
VALUES ("OKOK!!", 1, "2020-06-19 13:21:34", 1);
INSERT INTO comment (contents, user_id, created, issue_id)
VALUES ("Hi!!", 2, "2020-06-19 13:34:11", 1);
INSERT INTO comment (contents, user_id, created, issue_id)
VALUES ("HaHa!!", 1, "2020-06-22 16:21:34", 2);
INSERT INTO comment (contents, user_id, created, issue_id)
VALUES ("Hellooooo!!", 3, "2020-06-22 16:21:34", 3);
INSERT INTO comment (contents, user_id, created, issue_id)
VALUES ("Haaaaaa!!", 4, "2020-06-22 16:21:34", 3);

INSERT INTO issue_has_label (issue_id, label_id) VALUES (1, 1);
INSERT INTO issue_has_label (issue_id, label_id) VALUES (1, 2);
INSERT INTO issue_has_label (issue_id, label_id) VALUES (1, 3);
INSERT INTO issue_has_label (issue_id, label_id) VALUES (2, 2);
INSERT INTO issue_has_label (issue_id, label_id) VALUES (2, 3);

INSERT INTO assignee (issue_id, user_id) VALUES (1, 1);
INSERT INTO assignee (issue_id, user_id) VALUES (1, 2);
INSERT INTO assignee (issue_id, user_id) VALUES (1, 3);
INSERT INTO assignee (issue_id, user_id) VALUES (2, 2);
INSERT INTO assignee (issue_id, user_id) VALUES (2, 3);
INSERT INTO assignee (issue_id, user_id) VALUES (3, 3);
INSERT INTO assignee (issue_id, user_id) VALUES (4, 4);
