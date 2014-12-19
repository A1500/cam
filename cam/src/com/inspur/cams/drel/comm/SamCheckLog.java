package com.inspur.cams.drel.comm;
/**
 * 校验返回值bean
 * @author yanliangliang
 * @date 2014年7月17日
 */
public class SamCheckLog {
	//结果值
	private boolean result ;
	//结果信息
	private String context ;
	/**
	 * 结果值
	 */
	public boolean isResult() {
		return result;
	}
	/**
	 * 结果值
	 */
	public void setResult(boolean result) {
		this.result = result;
	}
	/**
	 *结果信息
	 */
	public String getContext() {
		return context;
	}
	/**
	 *结果信息
	 */
	public void setContext(String context) {
		this.context = context;
	}
}
