package com.inspur.cams.dataexchange.util;
/**
 * @title 用户登录处理类
 * @author YLL
 * @since 2013年6月3日
 */
public interface IDataExChangeLoginHandle {
	/**
	 * 用户登录方法
	 * @param userName	用户名
	 * @param password	密码
	 * @return <user-login>
	 * 				<code>登录编码<code/>
	 * 				<code-cn>登录编码汉意<code-cn/>
	 * 		   </user-login>
	 */
	public String login ( String userName , String password );
}
