/*eg: example*/configuration
/* create database*/
CREATE DATABASE if not exists TEST_20_7_21 default character set utf8 collate utf8_general_ci;
USE TEST_20_7_21;
/*create table fruit*/
CREATE table if not exists fruit 
(id int,name nvarchar(20),quarter int,number int);
/*make saome data on table fruit*/
insert into fruit (id, name, quarter, number)
values(1,N'苹果',1,1000),(1,N'苹果',2,2000),(1,N'苹果',3,4000),(1,N'苹果',4,5000),
      (2,N'梨子',1,3000),(2,N'梨子',2,3500),(2,N'梨子',3,4200),(2,N'梨子',4,5500);
/*--------------------------------------------------------------------------------*/
/*create database*/
/*
  SCM: 供应链管理
  ct: 合同
  coop: 合作
  ct_mb: 合同主体
  mt_code: 物料编码
*/
CREATE DATABASE IF NOT exists SCM_7_21 default character set utf8 collate utf8_general_ci;
USE SCM_7_21;
/*create table*/
/*s_info: 供应商信息表*/
/*id: 供应商编码、 c_name: 公司名称、 p_phonenum: 负责人联系电话、 e_addr: 邮件地址、 c_addr: 公司地址*/
CREATE table if not exists s_info(id char(6), c_name varchar(63), p_phonenmu char(11), e_addr varchar(50), c_addr varchar(50));
/*s_ct_info: 供应商合同信息表*/
/*id: 供应商编码、c_name: 公司名称、coop_car_type: 合作车型、ct_mb: 合同主体、mt_code：物料编码、mt_name: 物料名称、settlement_mode: 结算方式、val_clusive: 含税价格、price_inclusive: 价格有效期*/
CREATE table if not exists s_ct_info(id char(6), c_name varchar(63), coop_car_type enum("L10", "A16", "B11C"), ct_mb enum(0,1),
                                     mt_code varchar(12), mt_name varchar(150), settlement_mode varchar(30), vat_inclusive float(7,2),
									 price_inclusive char(21))；
/*stock_info: 库存信息表*/
/*id: 供应商编码、c_name：公司名称、mt_code: 物料编码、mt_name: 物料名称、stock_pos: 仓储位置、incoming_quantity: 入库数量、incoming_time: 入库时间、stock_num: 库存数量*/
CREATE table if not exists stock_info(id char(6), c_name varchar(63), mt_code varchar(12), mt_name varchar(150), 
									  stock_pos varchar(7), incoming_quantity mediumint(1), incoming_time datetime, stock_num mediumint(1));
/*car_cf: 车型配置表*/
/* "A"、"B"、"C": 车型配置 */
CREATE table if not exists car_cf(id char(8), coop_car_type enum("L10", "A16", "B11C"), mt_code varchar(12), mt_name varchar(150), "A", "B", "C")
/*standing_book: 台账*/
/*bil_code: 发票号、bil_start_date: 发票日期、pay_content: 发票内容、bil_amount: 发票金额、bil_deal_way: 发票处理方式、pay_done_amount: 发票已付金额、pay_undone_amount: 发票待付金额、*/
CREATE table if not exists standing_book(id char(6), bil_code char(8), bil_start_date datetime, pay_content varchar(60), bil_amoount int(1), 
                                         bil_deal_way enum("pay", "hang up", "wash out"), pay_done_amount int(1), pay_undone_amount int(1), remake varchar(100));
/*s_score_manage: 供应商评分管理*/
/*score_rank: 评分等级, alternate_exists: 是否存在替选*/
CREATE table if not exists s_score_manage(id char(6), socre_rank enum("normal", "bad", "good"), alternate_exists enum("yes", "no"), remake varchar(100));


,										 