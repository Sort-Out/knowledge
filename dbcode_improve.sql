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
/*--------------------------------*/
/*supplier_id_contrast: 供应商编码对照表*/
/*supplier_id: 供应商编码、c_name: 供应商名称 */
CREATE table if not exists supplier_id_contrast(supplier_id varchar(7) primary key, c_name varchar(63) unique);

/*supplier_moduler_constrast: 供应商模块对照表*/
/*supplier_id: 供应商编码、moduler: 模块*/
CREATE table if not exists supplier_moduler_contrast(supplier_id varchar(7) unique, moduler enum("冲压件", "底盘", "动总", "车身", "内外饰", "电器", "大宗物料"),
                                                     foreign key(supplier_id) references supplier_id_contrast(supplier_id) on delete cascade on update cascade);

/*cooperation_info：供应商合作信息*/
/*supplier_id: 供应商编码、coop_car_type: 合作车型*/
CREATE table if not exists cooperation_info(supplier_id varchar(7), coop_car_type enum("L10", "A16", "B11C", "L10/A16", "L10/B11C", "A16/B11C", "L10/A16/B11C"), 
                                            foreign key(supplier_id) references supplier_id_contrast(supplier_id) on delete cascade on update cascade);

/*supplier_info: 供应商基础信息表*/
/*c_name: 供应商名称、scope_of_business: 经营范围、p_phonenum: 负责人联系电话、e_addr: 邮件地址、c_addr：地址*/
CREATE table if not exists supplier_info(supplier_id varchar(7) unique, scope_of_business varchar(100), p_phonenum varchar(100), e_addr varchar(100), c_addr varchar(100)
                                         foreign key(supplier_id) references supplier_id_contrast(supplier_id) on delete cascade on update cascade);
/*----------------车型配置表----------------*/
/*物料编码对照表*/
/*mt_code: 物料编码、mt_name: 物料名称*/
CREATE table if not exists mtCode_mtName_contrast(mt_code varchar(100) primary key, mt_name varchar(63) unique);

/*物料车型对照表*/
/*mt_code: 物料编码、car_type: 车型、mtCode_usage: 用量*/
CREATE table if not exists mtCode_to_carType(mt_code varchar(100), car_type enum("L10", "A16", "B11C"), 
                                             mtCode_usage tinyint(1)  UNSIGNED, unique(mt_code, car_type),
                                             foreign key(mt_code) references mtCode_to_carType(mt_code) on delete cascade on update cascade);						   
/*----------------台账信息表----------------*/
/*发票信息表*/
/*invoice_num: 发票号、invoice_date: 发票日期、invoice_content: 发票内容、invoice_amoount: 发票金额、subject_of_signing: 发票主体*/
CREATE table if not exists invoice_info(invoice_num char(8) primary key, invoice_date date, invoice_content varchar(60),  invoice_amoount int(1)  UNSIGNED,
                                        subject_of_signing enum("母公司", "子公司"));
										
/*台账信息表*/
/*invoice_num: 发票号、dealer: 处理人员、invoice_deal_way: 发票处理状态、invoice_done_amount: 发票已付金额、remake: 备注*/
CREATE table if not exists standing_book(invoice_num char(8) unique, dealer varchar(12), invoice_deal_way enum("pay", "hang up", "wash out"), invoice_done_amount int(1)  UNSIGNED, remake char(100),
                                         foreign key(invoice_num) references invoice_info(invoice_num));																											  
/*----------------合同、价格协议签订信息表----------------*/
/*合同与价格协议对照表*/
/*contract_num: 合同编号、protocol_num: 价格协议编号*/
CREATE table if not exists contract_to_protocol(contract_num char(20) primary key, supplier_id char(7), protocol_num char(23) unique,
                                                foreign key(supplier_id) references supplier_id_contrast(supplier_id));		
												
/*supplier_ct_info: 合同信息表*/
/*contract_num: 合同编号、subject_of_signing：签订主体、sign_addr: 签订地点、sign_date: 签订时间*/
CREATE table if not exists contract_info(contract_num char(20) unique, coop_car_type enum("L10", "A16", "B11C", "L10/A16", "L10/B11C", "A16/B11C", "L10/A16/B11C"),
                                         subject_of_signing enum("母公司", "子公司"), sign_addr varchar(100), sign_date date, 
                                         foreign key(contract_num) references contract_to_protocol(contract_num));
										 
/*protocol_info: 价格协议表*/
/*protocol_num: 价格协议编号、mt_code: 物料编码、val_clusive: 含税价格, s_price_of_valid: 有效期开始时间、e_price_of_validity: 有效期结束时间、method_of_settlement: 结算方式*/
CREATE table if not exists protocol_info(protocol_num char(23), mt_code varchar(100), val_clusive int(1)  UNSIGNED, s_price_of_validity date, 
                                         e_price_of_validity date, method_of_settlement enum("上线", "入库", "预付款"),
										 foreign key(protocol_num) references contract_to_protocol(protocol_num));
/*----------------库存信息表----------------*/
/*stock_info: 库存信息表*/
/*supplier_id: 供应商编码、mt_code: 物料编码、stock_pos: 仓储位置、incoming_quantity: 入库数量、incoming_time: 入库时间、positive_goods:可用库存, defective_goods: 不良品库存*/
CREATE table if not exists stock_info(supplier_id varchar(7), mt_code varchar(100), stock_pos varchar(7), incoming_quantity mediumint(1)  UNSIGNED, 
                                      incoming_time date, positive_goods mediumint(1)  UNSIGNED, defective_goods mediumint(1)  UNSIGNED,
									  foreign key(supplier_id) references supplier_id_contrast(supplier_id),
                                      foreign key(mt_code) references mtCode_to_carType(mt_code));
/*----------------供应商评分表----------------*/
/*supplier_score: 供应商评分管理*/
/*supplier_id: 供应商编码、score_rank: 评分等级, alternate_of_supplier: 替补供应商, remake: 备注*/
CREATE table if not exists supplier_score(supplier_id varchar(7) unique, socre_rank enum("normal", "bad", "good"), 
										  if_exists_alternate boolean, remake char(100), 
										  foreign key(supplier_id) references supplier_id_contrast(supplier_id),
										  );
/*----------------供应商开发表----------------*/
/*supplier_dvpt: 供应商开发表*/
/*supplier_id: 供应商编码、cont_for_dvpt: 开发内容、dvpt_progress: 开发进度、participant: 参与人员*/
CREATE table if not exists supplier_dvpt(supplier_id varchar(7), cont_for_dvpt varchar(500), dvpt_progress varchar(500), participant varchar(500),
                                         foreign key(supplier_id) references supplier_id_contrast(supplier_id));	
/*supplier_alternate: B点供应商对照表*/
/*supplier_id_A: A点供应商、supplier_id_B: B点供应商*/
CREATE table if not exists supplier_alternate(supplier_id_A varchar(7), supplier_id_A
                                              foreign key(supplier_id_A) references supplier_id_contrast(supplier_id),
											  foreign key(supplier_id_B) references supplier_id_contrast(supplier_id),
											  );				 
/*----------------设变信息表----------------*/
/*design_change: 设变信息表*/
/*supplier_id: 供应商编码、cont_for_design: 设变内容、design_progress: 设变进度、participant: 参与人员*/
CREATE table if not exists design_change(supplier_id varchar(7), cont_for_design varchar(500), design_progress varchar(500), participant varchar(500),
										 foreign key(supplier_id) references supplier_info(supplier_id));
/*----------------资金预算表----------------*/
/*budget_for_produce: 资金预算表*/
/*supplier_id: 供应商编码, invoice_num: 发票号、bil_amount_to_pay：付款金额、time_to_pay：付款时间、type_of_payment: 付款方式、amount_for_goods_arriving: 到货数量、time_for_good_incoming：到货时间*/
create table if not exists budget_for_produce(supplier_id varchar(7), invoice_num char(8), bil_amount_to_pay int(1) UNSIGNED,  
											  time_to_pay date,  type_of_payment enum("现汇", "承兑"), 
											  amount_for_goods_arriving int(1) UNSIGNED, time_for_good_incoming date,
											  foreign key(supplier_id) references supplier_info(supplier_id));
									  
                              									  
							



















