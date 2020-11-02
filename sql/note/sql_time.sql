# 获取当前时间  2008-08-08 22:20:46
# select now();
# 把时间转换成指定格式的字符串 
# select date_format('2008-08-08 22:23:01', '%Y%m%d%H%i%s');
# 把字符串转换成日期
# select str_to_date('08/09/2008', '%m/%d/%Y'); 
# 把时间转换成秒、秒转换成时间
# select time_to_sec('01:00:05'); 
# select sec_to_time(3605); 
# 把数字拼凑时间函数
# select maketime(12,15,30);
# 获得时间戳函数
# select unix_timestamp();
# select unix_timestamp('2008-08-08 12:30:00');
# 把时间戳转换成日期
# select from_unixtime(1218124800);