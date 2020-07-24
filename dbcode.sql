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
/*--------------------------related to supplier--------------------------*/
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
/*main_subject_for_pay: 付款主体、supplier: 供应商、bil_code: 发票号、bil_start_date: 发票日期、pay_content: 发票内容、bil_amount: 发票金额、bil_deal_way: 发票处理方式、pay_done_amount: 发票已付金额、pay_undone_amount: 发票待付金额、*/
CREATE table if not exists standing_book(id char(6), main_subject_for_pay enum("母公司", "子公司"), supplier varchar(500), bil_code char(8), bil_start_date datetime, pay_content varchar(60), bil_amoount int(1), 
                                         bil_deal_way enum("pay", "hang up", "wash out"), pay_done_amount int(1), pay_undone_amount int(1), remake varchar(100));
/*s_score_manage: 供应商评分管理*/
/*score_rank: 评分等级, alternate_exists: 是否存在替选*/
CREATE table if not exists s_score_manage(id char(6), socre_rank enum("normal", "bad", "good"), alternate_exists enum("yes", "no"), remake varchar(100));
/*--------------------------related to improvement--------------------------*/
/*s_dvpt: 供应商开发表*/
/*cont_for_dvpt: 开发内容、dvpt_progress: 开发进度、participant: 参与人员*/
CREATE table if not exists s_dvpt(id char(6), c_name varchar(63), cont_for_dvpt varchar(500), dvpt_progress varchar(500), participant varchar(500));
/*design_change: 设变信息表*/
/*cont_for_design: 设变内容、design_progress: 设变进度、participant: 参与人员*/
CREATE table if not exists design_change(id char(6), c_name varchar(63), cont_for_design varchar(500),  design_progress varchar(500), participant varchar(500));		
/*--------------------------budget_for_produce --------------------------*/
/*process_for_oa: OA流程进度、type_of_payment: 付款方式、amount_for_goods: 到货数量、time_for_good：到活时间*/
create table if not exists budget_for_produce(id char(6), coop_car_type enum("L10", "A16", "B11C"), process_for_oa enum("归档", "财务审批", "采购员"),  pay_content varchar(60),
                                              main_subject_for_pay enum("母公司", "子公司")，supplier_be_paid varchar(500), bil_amoount int(1), payer varchar(12), time_to_pay datetime, 
											  bil_amount_to_pay int(1), type_of_payment enum("现汇"), amount_for_goods int(1), time_for_good datetime);