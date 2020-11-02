use test_8_21;
# 1、查询"01"课程比"02"课程成绩高的学生的信息及课程分数 
-- select a.*, b.s_score as 01_score, c.s_score as 02_score from student a 
-- join score b on a.s_id = b.s_id	and b.c_id = "01"
-- left join score c on a.s_id = c.s_id and c.c_id = '02'
-- where b.s_score > c.s_score;
# 2、查询"01"课程比"02"课程成绩低的学生的信息及课程分数
-- select a.*, t.cid_01, t.cid_02 from student a 
-- join
-- (select distinct a.s_id as 'sid', a.s_score as 'cid_01', b.s_score as 'cid_02' from score a, score b 
-- where a.s_id = b.s_id and a.c_id = '01' and b.c_id = '02' and a.s_score < b.s_score) t
-- on  a.s_id = t.sid;
# 3、查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
-- select a.s_id, a.s_name, round(avg(b.s_score), 2) as avg_score from student a
-- join score b on a.s_id = b.s_id group by a.s_id, a.s_name having round(avg(b.s_score), 2)>=60;
# 4、查询平均成绩小于60分的同学的学生编号和学生姓名和平均成绩 (包括有成绩的和无成绩的)
-- select a.s_id, a.s_name, round(avg(b.s_score), 2) as avg_score from student a
-- left join score b on a.s_id = b.s_id group by a.s_id, a.s_name having round(avg(b.s_score), 2)<=60
-- union 
-- select a.s_id, a.s_name, 0 from student a
-- where a.s_id not in (select distinct s_id from score); 
# 5、查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩
-- select a.s_id, a.s_name, count(b.s_id) as sum_course, sum(b.s_score) as totol_score 
-- from student a left join score b on a.s_id = b.s_id group by a.s_id, a.s_name;  
# 6、查询"李"姓老师的数量
-- select count(t_id) from teacher where t_name like "李%";
# 7、查询学过"张三"老师授课的同学的信息
-- select a.* from student a join scoref b on a.s_id = b.s_id where b.c_id in 
-- (select c_id from course where t_id = (select t_id from teacher where t_name = "张三"));
# 8、查询没学过"张三"老师授课的同学的信息  
-- select * from student where s_id not in 
-- (select a.s_id from student a inner join score b on a.s_id = b.s_id where 
-- b.c_id in (select c_id from course where t_id = (select t_id from teacher where t_name = "张三")));
# 9、查询学过编号为"01"并且也学过编号为"02"的课程的同学的信息
-- select * from student b
-- where s_id in 
-- (select a.s_id from student a join score b on a.s_id = b.s_id where c_id = "01" and a.s_id in 
-- (select a.s_id from student a join score b on a.s_id = b.s_id where c_id = "02")); 
# 10、查询学过编号为"01"但是没有学过编号为"02"的课程的同学的信息
-- select * from student b
-- where s_id in 
-- (select a.s_id from student a join score b on a.s_id = b.s_id where c_id = "01" and a.s_id not in  
-- (select a.s_id from student a join score b on a.s_id = b.s_id where c_id = "02")); 
# 11、查询没有学全所有课程的同学的信息
-- select * from student where s_id in 
-- (select a.s_id from student a join score b on a.s_id = b.s_id group by a.s_id 
-- having count(b.c_id) < (select count(c_id) from course));
# 12、查询至少有一门课与学号为"01"的同学所学相同的同学的信息 
-- select * from student where s_id in 
-- (select a.s_id from student a join score b on a.s_id = b.s_id where b.c_id in 
-- (select c_id from score where s_id = '01')) and s_id != '01' ;
# 13、查询和"01"号的同学学习的课程完全相同的其他同学的信息 
-- select * from student where s_id in 
-- (select distinct s_id from score where s_id != 1 and c_id in 
-- (select c_id from score where s_id = '01')
-- group by s_id having count(*) = (select count(*) from score where s_id = '01')
-- );
# 14、查询没学过"张三"老师讲授的任一门课程的学生姓名
-- select s_name from student where s_id not in 
-- (select distinct s_id from score where c_id in    
-- (select c_id from course where t_id = (select t_id from teacher where t_name = '张三')));
# 15、查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩 
-- select a.s_id, a.s_name, round(avg(b.s_score), 2) from student a 
-- join score b on a.s_id = b.s_id where a.s_id in 
-- (select s_id from score where s_score < 60 group by s_id having count(*) >= 2)
-- group by a.s_id, a.s_name;
# 16、检索"01"课程分数小于60，按分数降序排列的学生信息
-- select a.* , b.s_score from student a, score b where a.s_id = b.s_id and b.c_id = '01' 
-- and b.s_score < 60 order by b.s_score desc;  
# 17、按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩
-- select a.s_id, (select s_score from score where a.s_id = s_id and  c_id = '01') as '语文',
-- 			 (select s_score from score where a.s_id = s_id and  c_id = '02') as '数学',
-- 			 (select s_score from score where a.s_id = s_id and  c_id = '03') as '英语',
-- 	  round(avg(a.s_score), 2) as '平均分' from score a group by a.s_id order by avg(a.s_score) desc;
# 18.查询各科成绩最高分、最低分和平均分：以如下形式显示：课程ID，
#    课程name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率
#    及格为>=60，中等为：70-80，优良为：80-90，优秀为：>=90
-- select b.c_id as '课程id', b.c_name as '课程名', max(a.s_score) as '最高分', min(a.s_score) as '最低分', round(avg(a.s_score), 2) as '平均分',
--        round(100*sum(case when a.s_score >= 60 then 1 else 0 end)/sum(case when a.s_score then 1 else 0 end), 2) as '及格率',
--        round(100*sum(case when a.s_score >= 70 and a.s_score <= 80 then 1 else 0 end)/sum(case when a.s_score then 1 else 0 end), 2) as '中等率',
--        round(100*sum(case when a.s_score >= 80 and a.s_score <= 90 then 1 else 0 end)/sum(case when a.s_score then 1 else 0 end), 2) as '优良率',
--        round(100*sum(case when a.s_score >= 90 then 1 else 0 end)/sum(case when a.s_score then 1 else 0 end), 2) as '优秀率'
--        from score a, course b where b.c_id = a.c_id group by a.c_id; 
# 19、按各科成绩进行排序，并显示排名(实现不完全)
# 20、查询学生的总成绩并进行排名
-- select a.s_id, a.s_name, sum(b.s_score) as '总分' from student a, score b 
-- where a.s_id = b.s_id group by a.s_id order by sum(b.s_score) desc;
# 21、查询不同老师所教不同课程平均分从高到低显示 
-- select distinct c.t_name, a.c_name, round(avg(b.s_score), 2) from course a, score b, teacher c
-- where a.c_id = b.c_id and c.t_id = a.t_id group by c.t_name order by round(avg(b.s_score), 2) desc;  
# 22、查询所有课程的成绩第2名到第3名的学生信息及该课程成绩
-- (select c.c_id, a.c_name, b.s_name, c.s_score from course a, student b, score c where c.c_id='01' 
-- and c.c_id = a.c_id and c.s_id = b.s_id order by c.s_score desc limit 1, 2 )
-- union 
-- (select c.c_id, a.c_name, b.s_name, c.s_score from course a, student b, score c where c.c_id='02' 
-- and c.c_id = a.c_id and c.s_id = b.s_id order by c.s_score desc limit 1, 2 )
-- union 
-- (select c.c_id, a.c_name, b.s_name, c.s_score from course a, student b, score c where c.c_id='03' 
-- and c.c_id = a.c_id and c.s_id = b.s_id order by c.s_score desc limit 1, 2 )
# 23、统计各科成绩各分数段人数：课程编号,课程名称,[100-85],[85-70],[70-60],[0-60]及所占百分比
-- select a.c_id, a.c_name, 
-- 	round(100 * sum(case when b.s_score <=100 and b.s_score > 85 then 1 else 0 end)/sum(case when b.s_score then 1 else 0 end), 2) as '[100-85]',
--     round(100 * sum(case when b.s_score <= 85 and b.s_score > 70 then 1 else 0 end)/sum(case when b.s_score then 1 else 0 end), 2) as '[85-70]',
--     round(100 * sum(case when b.s_score <= 70 and b.s_score > 60 then 1 else 0 end)/sum(case when b.s_score then 1 else 0 end), 2) as '[70-60]',
--     round(100 * sum(case when b.s_score <= 60 and b.s_score > 0 then 1 else 0 end)/sum(case when b.s_score then 1 else 0 end), 2) as '[0-60]'
--     from course a, score b where a.c_id = b.c_id group by c_id;
# 24、查询学生平均成绩及其名次
-- select a.s_name, round(avg(b.s_score), 2) as '平均成绩' from student a, score b 
-- where a.s_id = b.s_id group by a.s_name order by b.s_score desc; 
# 25、查询各科成绩前三名的记录
#     1.选出b表比a表成绩大的所有组
#     2.选出比当前id成绩大的 小于三个的
# 26、查询每门课程被选修的学生数 
-- select a.c_id, a.c_name, count(b.s_id) from course a, score b where a.c_id = b.c_id group by a.c_id;
# 27、查询出只有两门课程的全部学生的学号和姓名
-- select a.s_id as '学号',  b.s_name as '姓名' from score a, student b
-- where a.s_id = b.s_id group by b.s_name having count(*) = 2;
# 28、查询男生、女生人数
-- select s_sex, count(s_sex) from student group by s_sex;
# 29、查询名字中含有"风"字的学生信息
-- select * from student  where s_name like '%风%'
# 30、查询同名同性学生名单，并统计同名人数
# 31、查询1990年出生的学生名单
-- select * from student where left(s_birth, 4) = '1990';
# 32、查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列
-- select a.c_name as '课程名', round(avg(b.s_score), 2) as '平均成绩' from course a, score b
-- where a.c_id = b.c_id group by a.c_id order by round(avg(b.s_score), 2) desc, b.c_id asc; 
# 33、查询平均成绩大于等于85的所有学生的学号、姓名和平均成绩
-- select a.s_id, a.s_name, round(avg(b.s_score),2) from student a, score b 
-- where a.s_id = b.s_id group by a.s_name having round(avg(b.s_score),2) >= 85;
# 34、查询课程名称为"数学"，且分数低于60的学生姓名和分数
-- select a.s_name, b.s_score as '数学成绩' from student a, score b
-- where a.s_id = b.s_id and b.c_id = (select c_id from course where c_name = '数学'
-- ) group by a.s_name having b.s_score < 60;
# 35、查询所有学生的课程及分数情况
-- select a.s_name, 
--    sum(case when c.c_name = '语文' then b.s_score else 0 end) as '语文成绩',
--    sum(case when c.c_name = '数学' then b.s_score else 0 end) as '数学成绩',
--    sum(case when c.c_name = '英语' then b.s_score else 0 end) as '英语成绩',
--    sum(b.s_score) as '总分'
--    from student a, score b, course c where a.s_id = b.s_id and c.c_id = b.c_id group by a.s_id;
# 36、查询任何一门课程成绩在70分以上的姓名、课程名称和分数； 
-- select a.s_name, b.c_name, c.s_score from student a, course b, score c
-- where a.s_id = c.s_id and b.c_id = c.c_id and a.s_id not in 
-- (select s_id from score where s_score < 70 );
# 37、查询不及格的课程
-- select a.s_id, b.c_name, a.s_score from score a, course b
-- where a.c_id = b.c_id and a.s_score < 60;
# 38、查询课程编号为01且课程成绩在80分以上的学生的学号和姓名；
-- select a.s_id, a.s_name, b.s_score from student a, score b
-- where a.s_id = b.s_id and b.c_id = '01' and b.s_score > 80;
#　39、求每门课程的学生人数
-- select c_id, count(s_id) from score group by c_id;
# 40、查询选修"张三"老师所授课程的学生中，成绩最高的学生信息及其成绩
-- select t.c_id , m.s_id, n.s_name from 
-- (select a.c_id, max(a.s_score) as 'max_score' from score a where a.c_id in 
-- (select b.c_id from course b, teacher c where b.t_id = c.t_id and c.t_name = '张三') 
-- group by a.c_id) t, score m, student n where m.c_id = t.c_id and m.s_score = t.max_score and n.s_id = m.s_id;  
# 41、查询每个课程存在成绩相同的学生的学生编号、课程编号、学生成绩
-- select m.s_id, m.s_name, n.cid, n.sc from student m
-- join 
-- (select a.s_id as 'sid', a.c_id as 'cid', t.s_score as 'sc' from score a
-- join
-- (select c_id, s_score from score group by c_id, s_score having count(*) >1) t
-- on a.c_id = t.c_id and a.s_score = t.s_score)n
-- on m.s_id = n.sid;
# 41.2、查询不同课程成绩相同的学生的学生编号、课程编号、学生成绩
# 第一种解法: 子查询
-- select s_id, c_id, s_score from score where s_score in 
-- (select s_score from score group by s_score having count(*) > 1);
# 第二种解法：多表去重查询
-- select DISTINCT b.s_id,b.c_id,b.s_score from score a,score b
-- where a.c_id != b.c_id and a.s_score = b.s_score
# 42、查询每门成绩最好的前两名 
-- select a.s_id, a.c_id, a.s_score from score a where
-- (select count(1) from score b where a.c_id = b.c_id and b.s_score >= a.s_score) <= 2 order by a.c_id ;
# 43、统计每门课程的学生选修人数（超过5人的课程才统计）。
# 要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列
-- select c_id, count(s_id) from score group by c_id having count(s_id) = 5
-- order by count(s_id) desc, c_id asc;
# 44、检索至少选修两门课程的学生学号
-- select s_id from score group by s_id having count(c_id) >=2;
# 45、查询选修了全部课程的学生信息
-- select * from student where s_id in 
-- (select s_id from score group by s_id having count(c_id) = (select count(*) from course));
# 46、查询各学生的年龄按照出生日期来算，当前月日 < 出生年月的月日则，年龄减一
# 47、查询本周过生日的学生
-- select s_id from student where week(s_birth) = week(now());
# 48、查询下周过生日的学生
-- select s_id from student where week(s_birth) - 1 = week(now());
# 49、查询本月过生日的学
-- select s_id from student where month(s_birth) = month(now());
# 50、查询下月过生日的学生
-- select s_id from student where month(s_birth) - 1 = month(now());
