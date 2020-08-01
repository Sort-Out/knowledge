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
/*
  逻辑：
        父表：
		      供应商信息表【"供应商编码\公司名称" 唯一】
		      车型配置表【"物料编码\物料名称"唯一】
			  台账表【"发票号"唯一】
	    子表: 供应商合同信息表、库存信息表、台账、供应商评分管理

		可级联删除：  评分管理表、开发表、设变信息表、资金预算表
		不可级联删除：合同信息表[涉及残余账务库存等]、库存信息表[涉及残余库存]、车型配置表[涉及整车零件遗漏]
*/
/*--------------------------related to supplier--------------------------*/
/*----------------主表----------------*/
/*coop_*/
/*supplier_info: 供应商信息表*/
/*id: 供应商编码、c_name: 公司名称、moduler: 模块、 coop_car_type：合作车型、p_in_charge: 联系人、p_phonenum: 负责人联系电话、 e_addr: 邮件地址、 c_addr: 公司地址*/
CREATE table if not exists supplier_info(id varchar(7), c_name varchar(63), moduler enum("冲压件", "底盘", "动总", "车身", "内外饰", "电器", "大宗物料"),
                                  coop_car_type varchar(20), p_in_charge varchar(150), p_phonenum varchar(100), e_addr varchar(100), 
								  c_addr varchar(50), primary key(id, c_name));
/*vehicle_configuration: 车型配置表*/
/* "A"、"B"、"C": 车型配置 */
CREATE table if not exists vehicle_configuration(id varchar(7), c_name varchar(63), coop_car_type varchar(20), mt_code varchar(12), mt_name varchar(150),
                                  primary key(mt_code, mt_name),
                                  constraint fk_vehicle_configuration foreign key(id, c_name) references supplier_info(id, c_name));
/*standing_book: 台账*/
/*main_subject_for_pay: 付款主体、invoice_num: 发票号、invoice_date: 发票日期、invoice_content: 发票内容、invoice_amoount: 发票金额、invoice_deal_way: 发票处理方式、invoice_done_amount: 发票已付金额、invoice_undone_amount: 发票待付金额、*/
CREATE table if not exists standing_book(id varchar(7), c_name varchar(63), main_subject_for_pay enum("母公司", "子公司"), 
                                         invoice_num char(8) primary key, invoice_date date, invoice_content varchar(60), 
										 invoice_amoount int(1), invoice_deal_way enum("pay", "hang up", "wash out"), invoice_done_amount int(1), 
										 invoice_undone_amount int(1),  remake varchar(100),
										 constraint fk_standing_book foreign key(id, c_name) references supplier_info(id, c_name));								  
/*----------------分表----------------*/								  
/*supplier_ct_info: 供应商合同信息表*/
/*id: 供应商编码、c_name: 公司名称、coop_car_type: 合作车型、ct_mb: 合同主体、mt_code：物料编码、mt_name: 物料名称、settlement_mode: 结算方式、val_clusive: 含税价格、price_inclusive: 价格有效期*/
CREATE table if not exists supplier_ct_info(id varchar(7), c_name varchar(63), coop_car_type varchar(20), ct_mb enum('0','1'),
                                     mt_code varchar(12), mt_name varchar(150), settlement_mode varchar(30), vat_inclusive float(7,2),
									 price_inclusive char(21), 
									 constraint fk_supplier_ct_info foreign key(id, c_name) references supplier_info(id, c_name),
									 constraint fk_supplier_ct_info_2 foreign key(mt_code, mt_name) references vehicle_configuration(mt_code, mt_name));
/*stock_info: 库存信息表*/
/*id: 供应商编码、c_name：公司名称、mt_code: 物料编码、mt_name: 物料名称、stock_pos: 仓储位置、incoming_quantity: 入库数量、incoming_time: 入库时间、stock_num: 库存数量*/
CREATE table if not exists stock_info(id varchar(7), c_name varchar(63), mt_code varchar(12), mt_name varchar(150),  
									  stock_pos varchar(7), incoming_quantity mediumint(1), incoming_time date, stock_num mediumint(1),
									  constraint fk_stock_info_2 foreign key(mt_code, mt_name) references vehicle_configuration(mt_code, mt_name), 
									  constraint fk_stock_info foreign key(id, c_name) references                                                                                                                                                                                                                               supplier_info(id, c_name));
/*supplier_score: 供应商评分管理*/
/*score_rank: 评分等级, alternate_exists: 是否存在替选*/
CREATE table if not exists supplier_score(id varchar(7), c_name varchar(63), socre_rank enum("normal", "bad", "good"), 
                                          alternate_exists enum("yes", "no"), remake varchar(100),
										  constraint fk_supplier_score_manage foreign key(id, c_name) references supplier_info(id, c_name) on delete cascade 
										  on update cascade);
/*supplier_dvpt: 供应商开发表*/
/*cont_for_dvpt: 开发内容、dvpt_progress: 开发进度、participant: 参与人员*/
CREATE table if not exists supplier_dvpt(id varchar(7), c_name varchar(63), cont_for_dvpt varchar(500), dvpt_progress varchar(500), 
                                  constraint fk_supplier_dvpt foreign key(id, c_name) references supplier_info(id, c_name) on delete cascade on update cascade, 
								  participant varchar(500));
								  
/*design_change: 设变信息表*/
/*cont_for_design: 设变内容、design_progress: 设变进度、participant: 参与人员*/
CREATE table if not exists design_change(id varchar(7), c_name varchar(63), cont_for_design varchar(500),  
                                         design_progress varchar(500), participant varchar(500),
										 constraint fk_design_change foreign key(id, c_name) references supplier_info(id, c_name) on delete cascade 
										 on update cascade);		
/*budget_for_produce: 资金预算表*/
/*processupplier_for_oa: OA流程进度、type_of_payment: 付款方式、pay_content：付款内容、amount_for_goods: 到货数量、time_for_good_incoming：到货时间*/
create table if not exists budget_for_produce(id varchar(7), c_name varchar(63), coop_car_type varchar(20), 
                                              processupplier_for_oa enum("归档", "财务审批", "采购员"),  pay_content varchar(60), 
											  main_subject_for_pay enum("母公司", "子公司"), bil_amoount int(1), payer varchar(12), 
											  time_to_pay date, bil_amount_to_pay int(1), type_of_payment enum("现汇"), 
											  amount_for_goods int(1), time_for_good_incoming date,
											  constraint fk_budget_for_produce foreign key(id, c_name) references supplier_info(id, c_name));