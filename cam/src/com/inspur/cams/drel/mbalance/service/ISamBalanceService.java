package com.inspur.cams.drel.mbalance.service;

import com.inspur.cams.drel.mbalance.data.BalanceInfo;
import com.inspur.cams.drel.mbalance.data.BalancePreReturn;
import com.inspur.cams.drel.mbalance.data.CheckReturn;
import com.inspur.cams.drel.mbalance.data.ExpenseDetail;
import com.inspur.cams.drel.mbalance.data.HospitalRecord;
import com.inspur.cams.drel.mbalance.data.OperationReturn;

/**
 * 医疗救助一站式结算系统发布WebServices，供保险系统调用接口
 * @author 路国隋
 * 2011-10-17
 */
public interface ISamBalanceService {
	
	/**
	 * 保存入院备案信息
	 * @param hisRecord 入院备案信息对象
	 * @return 操作信息返回值
	 */
	public OperationReturn  saveInRecord(HospitalRecord hisRecord);
	
	/**
	 * 保存出院结算信息或冲账信息
	 * @param balanceInfo 出院结算信息对象 Type String类型，操作类型；
	 * @return 操作信息返回值
	 */
	public OperationReturn  balance(BalanceInfo balanceInfo);
	
	/**
	 * 保存费用明细信息
	 * @param detailArr 费用明细信息对象数组
	 * @return 操作信息返回值
	 */
	public OperationReturn  saveExpenseDetail(ExpenseDetail[] detailArr );

	/**
	 * 根据入院备案信息核对入院人员是否具有低保五保身份
	 * @param idCard idCard 18位身份证号码 
	 * @return 公民业务核查信息返回值
	 */
	public CheckReturn  checkIdentity (String idCard);

	/**
	 * 查询结算准备信息
	 * @param idCard idCard 18位身份证号码
	 * @return 公民业务核查信息返回值
	 */
	public BalancePreReturn  queryBalancePre(String idCard ,String inDate );
	
	/**
	 * 查询救助比例
	 * @param domicileCode 救助对象属地行政区划 
	 * @param payBase 救助基数
	 * @param assitanceType  救助对象类别
	 * @return 救助比例，string类型
	 */
	public String  queryPercentage(String domicileCode,String payBase,String assitanceType,String inDate);
	
	public String queryBptPercentage(String domicileCode, String payBase,String bptType,String disabilityLevel,String inDate) ;
}
