package com.inspur.cams.dataexchange.marry.domain;
/**
 * 数据共享婚姻系统接口
 * @author YLL
 * @since 2013年5月22日
 */
public interface IDataExChangeMarry {
	/**
	 * @param userId 帐号
	 * @param passWord 密码
	 * @param CertNumMan 男性证件号码
	 * @param CertNumWoman 女性证件号码
	 * @return 男方或女方当事人最后一条婚姻信息记录
	 */
	public String getMarryLastInfoByCert(String userId , String passWord , String CertNumMan, String CertNumWoman); 
	/**
	 * @param userId 帐号
	 * @param passWord 密码
	 * @param CertNumMan 男性证件号码
	 * @param CertNumWoman 女性证件号码
	 * @return 男方或女方当事人有关婚姻信息记录
	 */
	public String getMarryAllInfoByCert (String userId , String passWord , String CertNumMan, String CertNumWoman);

}
