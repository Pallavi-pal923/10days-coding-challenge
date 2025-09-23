CREATE DATABASE DAY5_CODING;
CREATE TABLE users ( 
    user_id INT PRIMARY KEY, 
    username VARCHAR(50), 
    join_date DATE, 
    country VARCHAR(50) 
);

INSERT INTO users (user_id, username, join_date, country) VALUES 
(1, 'johndoe', '2023-01-15', 'USA'), 
(2, 'janedoe', '2023-02-20', 'Canada'), 
(3, 'alice', '2023-03-10', 'UK'), 
(4, 'bobsmith', '2023-04-05', 'USA'), 
(5, 'charlie', '2023-05-22', 'Australia'), 
(6, 'dianne', '2023-06-18', 'Germany'), 
(7, 'edward', '2023-07-30', 'Brazil'), 
(8, 'fiona', '2023-08-01', 'France'), 
(9, 'george', '2023-09-12', 'USA'), 
(10, 'helen', '2024-01-01', 'Japan'), 
(11, 'ivan', '2024-02-14', 'India'), 
(12, 'julie', '2024-03-25', 'Canada'), 
(13, 'karen', '2024-04-10', 'USA'), 
(14, 'leo', '2024-05-18', 'UK'), 
(15, 'mia', '2024-06-03', 'Australia'); 

SELECT * FROM USERS;


CREATE TABLE posts ( 
    post_id INT PRIMARY KEY, 
    user_id INT, 
    post_date DATETIME, 
    content TEXT, 
    likes INT, 
    FOREIGN KEY (user_id) REFERENCES users(user_id) 
); 

INSERT INTO posts (post_id, user_id, post_date, content, likes) VALUES 
(101, 1, '2023-02-01 10:00:00', 'Hello, World! My first post.', 5), 
(102, 2, '2023-03-05 14:30:00', 'Loving this new app!', 15), 
(103, 3, '2023-04-01 09:15:00', 'SQL is my favorite language.', 25), 
(104, 4, '2023-04-20 11:00:00', 'Just finished a marathon!', 50), 
(105, 1, '2023-05-10 18:00:00', 'Coffee and code on a Friday.', 12), 
(106, 5, '2023-06-01 12:00:00', 'Check out my new project.', 30), 
(107, 6, '2023-07-07 08:30:00', 'Travel is the best.', 8), 
(108, 7, '2023-08-15 16:00:00', 'Beautiful sunset in Brazil.', 60), 
(109, 8, '2023-09-20 19:00:00', 'New recipe I tried today.', 20), 
(110, 9, '2023-10-25 21:00:00', 'Happy Halloween!', 40), 
(111, 10, '2024-02-05 10:30:00', 'Exploring Tokyo.', 75), 
(112, 11, '2024-03-01 11:45:00', 'Coding for a cause.', 90), 
(113, 12, '2024-04-15 13:00:00', 'Feeling grateful today.', 35), 
(114, 13, '2024-05-01 15:00:00', 'May the 4th be with you!', 110), 
(115, 14, '2024-06-10 17:00:00', 'Enjoying the UK countryside.', 18);

SELECT * FROM POSTS;

CREATE TABLE comments ( 
    comment_id INT PRIMARY KEY, 
    post_id INT, 
    user_id INT, 
    comment_date DATETIME, 
    comment_text TEXT, 
    FOREIGN KEY (post_id) REFERENCES posts(post_id), 
    FOREIGN KEY (user_id) REFERENCES users(user_id) 
); 

INSERT INTO comments (comment_id, post_id, user_id, comment_date, comment_text) VALUES 
(1001, 101, 2, '2023-02-01 10:15:00', 'Welcome to the platform!'), 
(1002, 101, 3, '2023-02-01 10:20:00', 'Excited to have you here.'), 
(1003, 102, 1, '2023-03-05 14:45:00', 'Me too! It is great.'), 
(1004, 103, 4, '2023-04-01 09:30:00', 'I agree, SQL is powerful.'), 
(1005, 104, 1, '2023-04-20 11:30:00', 'Awesome, congrats!'), 
(1006, 104, 5, '2023-04-20 11:40:00', 'Inspirational!'), 
(1007, 105, 6, '2023-05-10 18:15:00', 'What are you working on?'), 
(1008, 106, 1, '2023-06-01 12:30:00', 'Looks interesting!'), 
(1009, 106, 7, '2023-06-01 12:45:00', 'Can you share the link?'), 
(1010, 108, 8, '2023-08-15 16:30:00', 'So beautiful!'), 
(1011, 110, 9, '2023-10-25 21:30:00', 'Great costume!'), 
(1012, 111, 1, '2024-02-05 11:00:00', 'Tokyo is amazing!'), 
(1013, 111, 12, '2024-02-05 11:15:00', 'I love Japan.'), 
(1014, 112, 13, '2024-03-01 12:00:00', 'This is a great initiative.'), 
(1015, 114, 1, '2024-05-01 15:30:00', 'Best day of the year!'); 

SELECT * FROM COMMENTS;

#Questions and Answers
#1---User Growth: Write a query to find the total number of new users per month for the 
#last two years. The result should show the year, month, and the count of new users. 


SELECT 
  YEAR(join_date) AS year,
  monthname(join_date) AS month,
  COUNT(user_id) AS new_users 
FROM users
WHERE join_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
GROUP BY year, month
ORDER BY year, month;

#2------Top Content: Identify the top 10 most liked posts of all time. The result should include 
#the post's content, the username of the creator, and the number of likes. 

select p.content , u.username, p.likes
from posts p
join users u
on p.user_id= u.user_id
order by p.likes desc
limit 10;

#3-----Engagement Rate: Calculate the average number of comments per post. Then, find the 
#user who has created the most comments and show their username and the total count of comments they've made. 

select avg(comment_count) as avg_comments_per_post
from(
      select post_id, count(comment_id) as comment_count
      from comments
      group by post_id
      ) as comment_summaary;

select u.username, count(comment_id) as total_comments
from comments c
join users u
on c.user_id=u.user_id
group by u.user_id, u.username
order by total_comments desc
limit 5;

#4---Power Users: Identify "power users" who have created at least 10 posts and 20 
#comments. The result should show the username and their total count of posts and comments. 

select u.username, coalesce(p.post_count,0) as total_posts,
 coalesce(c.comment_count,0) as total_comments
from users u
LEFT JOIN (
  SELECT user_id, COUNT(*) AS post_count
  FROM posts p 
  GROUP BY user_id
) 
p ON u.user_id = p.user_id
LEFT JOIN (
  SELECT user_id, COUNT(*) AS comment_count
  FROM comments c
  GROUP BY user_id
) 
c ON u.user_id = c.user_id
WHERE COALESCE(p.post_count, 0) >= 10
  AND COALESCE(c.comment_count, 0) >= 20
ORDER BY total_posts DESC, total_comments DESC;

SELECT user_id, COUNT(*) FROM posts GROUP BY user_id HAVING COUNT(*) >= 10;
SELECT user_id, COUNT(*) FROM comments GROUP BY user_id HAVING COUNT(*) >= 20;

#Geographic Analysis: Determine which countries have the highest average number of 
#likes per post. The query should return the top 5 countries along with their average likes per post, rounded to two decimal places

select u.country, round(avg(p.likes),2) as avg_likes_per_post
from posts p
join users u
on p.user_id= u.user_id
group by u.country
order by avg_likes_per_post desc
limit 5;







      



















