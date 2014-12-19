package com.inspur.cams.comm.extuser.webservice;

import com.inspur.cams.drel.mbalance.data.OperationReturn;

/**
 * 医疗救助一站式结算系统发布WebServices，供保险系统调用接口
 * @author 路国隋
 * 2011-10-17
 */
public interface IComExtUserLoginService {
	
	/**
	 * 保存入院备案信息
	 * @param hisRecord 入院备案信息对象
	 * @return 操作信息返回值
	 */
	public OperationReturn  login(String userName,String userPassWord);
	
	/**
	 * 保存出院结算信息或冲账信息
	 * @param balanceInfo 出院结算信息对象 Type String类型，操作类型；
	 * @return 操作信息返回值
	 */
	public OperationReturn  logout(String userName);
	
	
}
