-- 회원가입
INSERT INTO user VALUES ('email@email.com', 'p!ssw0rd', 'nickname', '01012345678', '부산광역시 부산진구','롯데백화점', null);

-- 로그인
SELECT * FROM user WHERE email = 'email@email.com';

-- 게시물 작성
INSERT INTO board (title, content, write_datetime, favorite_count, comment_count, view_count, writer_email)
VALUES ('제목입니다', '내용입니다', '2025-06-09 22:59', 0, 0, 0, 'email@email.com');

INSERT INTO image VALUES (1, 'url');

-- 댓글 작성
INSERT INTO comment (content, write_datetime, user_email, board_number) VALUES ('반값습니다', '2025-06-09 11:01', 'email@email.com', 1);
UPDATE board SET comment_count = comment_count+1 WHERE board_number = 1;

-- 좋아요
INSERT INTO favorite VALUES ('email@email.com', 1);
UPDATE board SET favorite_count = favorite_count+1 WHERE board_number = 1;

DELETE FROM favorite WHERE user_email = 'email@email.com' AND board_number = 1;
UPDATE board SET favorite_count = favorite_count-1 WHERE board_number = 1;

-- 게시물 수정
UPDATE board SET title = '수정 제목입니다', content = '수정 내용입니다' WHERE board_number = 1;
DELETE FROM image WHERE board_number = 1;
INSERT INTO image VALUES (1, 'url');


-- 게시물 삭제
DELETE FROM comment WHERE board_number = 1;
DELETE FROM favorite WHERE board_number = 1;
DELETE FROM board WHERE board_number = 1;

-- 상세 게시물 불러오기
SELECT 
    B.board_number AS board_number,
    B.title AS title,
    B.content AS content,
    B.write_datetime AS write_datetime,
    B.writer_email AS writer_email,
    U.nickname AS nickname,
    U.profile_image AS profile_image
FROM board as B
INNER JOIN user as U
ON B.writer_email = U.email;

SELECT image
FROM image
WHERE board_number = 1;

-- 최신 게시물 리스트 불러오기
SELECT 
    B.board_number AS board_number,
    B.title AS title,
    B.content AS content,
    I.image AS image,
    B.favorite_count AS favorite_count,
    B.comment_count AS comment_count,
    B.view_count AS view_count,
    B.write_datetime AS write_datetime,
    U.nickname AS nickname,
    U.profile_image AS writer_profile_image
FROM board AS B
INNER JOIN user AS U
ON B.writer_email = u.email
LEFT JOIN (SELECT board_number, ANY_VALUE(image) AS image from image GROUP BY board_number) AS I
ON B.board_number = I.board_number
ORDER BY write_datetime
LIMIT 5, 5;

-- 검색어 리스트
SELECT 
    B.board_number AS board_number,
    B.title AS title,
    B.content AS content,
    I.image AS image,
    B.favorite_count AS favorite_count,
    B.comment_count AS comment_count,
    B.view_count AS view_count,
    B.write_datetime AS write_datetime,
    U.nickname AS nickname,
    U.profile_image AS writer_profile_image
FROM board AS B
INNER JOIN user AS U
ON B.writer_email = u.email
LEFT JOIN (SELECT board_number, ANY_VALUE(image) AS image from image GROUP BY board_number) AS I
ON B.board_number = I.board_number
WHERE title LIKE '%제목%' or content LIKE '%수정%'
ORDER BY write_datetime;

-- 주간 상위 3
