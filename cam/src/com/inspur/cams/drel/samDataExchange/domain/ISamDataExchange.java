package com.inspur.cams.drel.samDataExchange.domain;
/**
 * 数据共享低保系统接口
 * @author YLL
 * @since 2013年12月12日
 */
public interface ISamDataExchange {
	/**
	 * @param Xml格式字符串
	 * @return 对于数据处理的结果，Xml格式字符串
	 */
	public String  sendSamExternalInfo(String xml);
	
	/**
	 * 
	 * @param idCardNo 身份证号
	 * @return 返回单独的一笔低保家庭信息，格式为Xml格式字符串
	 */
	public String returnSamFamilyInfo(String idCardNo);
	
}
