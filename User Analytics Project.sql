select * from comments;
select * from follows;
select * from likes;
select * from photo_tags;
select * from photos;
select * from tags;
select * from users;

-- QUES 1. FINDING THE OLDEST USERS ON INSTAGRAM

select * from users order by created_at limit 5;

-- QUES 2. USERS WHO HAVE NEVER POSTED A SINGLE IG PHOTO
 
select u.id, u.username, ph.id, ph.image_url 
from users as u left join photos as ph on u.id = ph.user_id
where ph.id is null order by u.username;
 
-- QUES 3. USER WITH THE MOST LIKED IG PHOTO
 
select ph.id, u.username, count(l.user_id) as no_of_likes
from photos ph inner join likes l
on l.photo_id = ph.id inner join users u on u.id = ph.user_id
group by l.photo_id order by count(l.user_id) desc limit 10;
 
-- QUES 4. TOP 5 USED HASHTAGS
select t.tag_name, count(pht.tag_id) as top_5_used_hashtags
from tags as t left join photo_tags as pht
on t.id = pht.tag_id group by t.tag_name order by count(pht.tag_id) desc limit 5;
 
-- QUES 5. DAY OF WEEK THAT IG USERS REGISTER THE MOST

select dayname(created_at) as day, count(dayname(created_at)) as num_freq
from users group by dayname(created_at) order by count(dayname(created_at)) desc;

-- QUES 6. HOW MANY TIMES DOES AVERAGE USER POSTS ON IG..

select distinct ph.user_id, u.username, count(ph.id) as 'No of Posts' from photos as ph inner join users as u
on u.id= ph.user_id group by ph.user_id order by count(ph.id) desc;

select count(distinct user_id) as "no of users", count(id) as "No of Posts",
(round(count(id)/count(distinct user_id),2)) as "Average Post per User" from photos;

-- QUES 7. ALSO PROVIDE TOTAL NO OF PHOTOS ON IG/TOTAL NO OF USERS

select count(ph.id) as "No of Photos", count(distinct u.id) as "No of Users" from photos ph right join users u
on u.id = ph.user_id;

select count(ph.id) as "No of Photos", count(distinct u.id) as "No of Users" from photos ph left join users u
on u.id = ph.user_id;

-- CORRECT ANSWERS
select count(distinct u.id) as "No of Users", count(ph.id) as "No of Photos", 
(count(ph.id)/count(distinct u.id)) as "Photos per User" 
from users u left join photos ph
on u.id = ph.user_id;

select count(ph.id) as "No of Photos", count(distinct u.id) as "No of Users",
(count(ph.id)/count(distinct u.id)) as "Photos per User"
from photos ph right join users u
on u.id = ph.user_id;


select count(distinct u.id) as "No of Users", count(ph.id) as "No of Photos" from users u inner join photos ph
on u.id = ph.user_id;

-- PROVIDE DATA ON USERS THAT HAVE LIKED EVERY SINGLE PHOTO ON IG

select distinct u.id, u.username, count(l.photo_id) as "No of Likes" from users u inner join likes l on
u.id = l.user_id group by u.id having count(l.photo_id) = 257;

select distinct u.id, u.username, count(l.photo_id) as "No of Likes" from users u inner join likes l on
u.id = l.user_id where l.photo_id in ( select * from likes having max(count(photo_id)));