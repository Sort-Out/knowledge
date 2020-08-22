use test_8_21;
# 1、查询"01"课程比"02"课程成绩高的学生的信息及课程分数 
-- select a.*, b.s_score as 01_score, c.s_score as 02_score from student a 
-- join score b on a.s_id = b.s_id	and b.c_id = "01"
-- left join score c on a.s_id = c.s_id and c.c_id = '02'
-- where b.s_score > c.s_score;
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












