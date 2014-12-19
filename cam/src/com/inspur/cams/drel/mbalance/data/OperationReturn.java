package com.inspur.cams.drel.mbalance.data;

/**
 * 入院备案、费用结算、费用明细方法返回值
 * @author 路国隋
 *	2011-10-17
 */
public class OperationReturn {

	//返回代码返回代码字典表
	private String returnCode;
	//返回描述
	private String returnCodeDes;
	
	public String getReturnCode() {
		return returnCode;
	}
	public void setReturnCode(String returnCode) {
		this.returnCode = returnCode;
	}
	public String getReturnCodeDes() {
		return returnCodeDes;
	}
	public void setReturnCodeDes(String returnCodeDes) {
		this.returnCodeDes = returnCodeDes;
	}
	
}
