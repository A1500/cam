package com.inspur.cams.dataexchange.fis.domain;
/**
 * 数据共享殡葬系统接口
 * @author YLL
 * @since 2013年5月22日
 */
public interface IDataExChangeFis {
	/**
	 * @param userId 帐号
	 * @param passWord 密码
	 * @param IdCard 逝者证件号码
	 * @return 殡葬火化信息
	 */
	public String getFuneralInfo(String userId , String passWord ,String IdCard);
}
