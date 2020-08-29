/*http://blog.sina.com.cn/s/blog_52d20fbf0100ofd5.html 资料参网址*/
/*
	参数：
	      in    输入参数     eg: in  p_in int 
		  out   输出参数     eg: out p_in int 
		  inout 输入输出参数eg:inout p_inout int  
		  
    变量:
	      declare l_int int unsigned default 40000;  
		  declare 语句必须出现在begin...end语句块之中，并且必须出现在begin...end语句块的最前面，也就是begin之后的第一句话
	赋值:         变量申明过程，不区分大小写。
	      set @x = "good"  #[select @x -> good]
		  set @z = 1+2+3;  #[select @z -> 6	]
		  
*/
/*
	cmd下执行procedure
	mysql > delimiter //          # 指定存储过程分隔符，因为sql语句以;作为分割符，如果没有声明分隔符，编译过程中，会把存储过程当成sql语句执行
	mysql > create procedure nu()
	           begin 
			     select 1;        # 主要业务逻辑
               end 
			 //
	mysql > delimiter ;           # 重新调回分隔符
	mysql > call nu()；           # 调用存储过程
             			   
*/

/*存储过程创建in 输入参数、inout 输入输出参数*/
/* in 输入参数 */
create procedure demo_in_parameter(in p_in int)
begin
    select p_in;
	set p_in = 2;
	select p_in;
end;

/* inout 输入输出参数*/
create procedure  demo_inout_parameter(inout p_inout int)
begin 
    select p_inout;
	set p_inout = 2;
	select p_inout;
end;
set @p_inout = 1;
call demo_inout_parameter(@p_inout);
select @p_inout;  # 输出结果2

/* 条件if else case */
delimiter //
create procedure proc2(in param int)
	begin
	    declare val int;                 # 如果在cmd下声明存储declare 变量，务必加上delimiter //分隔符申明            
		set val = param + 1;
		if val = 0 then 
		insert into test(id, name) values(1, '0');
		end if;
		if val = 1 then
		insert into test(id, name) values(1, '0');
		else 
		delete * from test;
		end if;
	end			
	//
delimiter ;

/* repeat end repeat 循环执行代码段 */
delimiter // 
create procedure proc5()
    begin
	    declare v int;
		set v = 0;
		repeat 
		insert into test(id, name) values(101, "0");
		set v = v + 1;
		until v >= 5;
		end repeat;
	end
	//
delimiter ;
		
/*存储过程删除  drop procedure 存储过程1*/
/*存储过程查看  show procedure status where db="数据库名"*/
