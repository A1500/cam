package com.inspur.cams.dataexchange.util;

import org.loushang.sca.ScaComponentFactory;
import com.inspur.cams.comm.extuser.data.ComExtUser;
import com.inspur.cams.comm.extuser.domain.IComExtUserDomain;
import com.inspur.cams.comm.extuser.util.Constant;
import com.inspur.cams.comm.util.Axis2Utils;


/**
 * @title webServices登录
 * @author YLL
 * @since 2013年6月3日 
 */
public class DataExChangeLoginHandle implements IDataExChangeLoginHandle{
	private IComExtUserDomain comExtUserDomain = (IComExtUserDomain) ScaComponentFactory.getService(IComExtUserDomain.class, "comExtUserDomain/comExtUserDomain");
	
	/**
	 * @param userId 帐号
	 * @param passWord 密码
	 * @return 登录状态
	 */
	public String login( String userName , String password ){
		
		StringBuffer returnXML = new StringBuffer("");
		if(!"".equals(userName.trim()) && !"".equals(password.trim()) ){
			//获得数据库中该用户名的用户
			ComExtUser comExtUser = comExtUserDomain.getComExtUser(userName.trim());
			if (comExtUser != null && password.trim().equals(comExtUser.getPwd())) {
				//登陆成功
				//returnXML.append("<ERROR>"+DataExChangeError.LOGIN_SUCCESS+"</ERROR>");
			}else{//用户名或密码错误
				returnXML.append("<ERROR>"+DataExChangeError.ID_OR_PASS_WORD_FALSE+"</ERROR>");
			}
		}else{//用户名或密码不能为空
			returnXML.append("<ERROR>"+DataExChangeError.NOT_NULL_LOGIN+"</ERROR>");
		}
		return returnXML.toString();
	}
}
