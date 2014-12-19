package com.inspur.cams.comm.util;



import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.bsp.share.organization.OrganFactory;
import org.loushang.bsp.share.organization.provider.IOrganProvider;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.next.web.cmd.CommandContext;


/**
 * @title:StruCommand
 * @description:用户command，根据前台传来的struId， 获取其所有用户，并封装成DataSet返回。
 * @author huangqiq
 * @since 2009-10-22
 * @version 1.0
 */
public class UserCommand extends BaseQueryCommand {
	private static IOrganProvider IOrgan=(IOrganProvider)OrganFactory.getIOrganProvider();
	@SuppressWarnings("unchecked")
	public static String getOrganCode(){
		String  organId=	GetBspInfo.getBspInfo(CommandContext.getRequest()).getDepartmentOrganId();
		String organCode =IOrgan.getOrganByOrganId(organId).getOrganCode();
		return organCode;
	}

	public static String getOrganName(){
		String  organId=	GetBspInfo.getBspInfo(CommandContext.getRequest()).getDepartmentOrganId();
		String organName =IOrgan.getOrganByOrganId(organId).getOrganName();
		return organName;
	}


	//取用户信息,userName
	@SuppressWarnings("unchecked")
	public static String getOrganType(){
		// 获取登录用户所在法人（市局、分局、工商所）编码
		String  organId=	GetBspInfo.getBspInfo(CommandContext.getRequest()).getDepartmentOrganId();
		String organType=IOrgan.getOrganByOrganId(organId).getOrganType();
		return organType;
	}



	public static String getSubOrganCode(){
		String  organId=	GetBspInfo.getBspInfo(CommandContext.getRequest()).getDepartmentOrganId();
		String organCode =IOrgan.getOrganByOrganId(organId).getOrganCode();
		if(organCode.length()==12){
			if("0000000000".equals(organCode.substring(2, 12))){//省局登陆
				organCode = organCode.substring(0, 2);
			}else if("00000000".equals(organCode.substring(4, 12))){//市局
				organCode = organCode.substring(0, 4);
			}else if("000000".equals(organCode.substring(6, 12))){//分局（县）
				organCode = organCode.substring(0, 6);
			}else if("000".equals(organCode.substring(9, 12))){//街道
				organCode = organCode.substring(0, 9);
			}
			}
		return organCode;
	}

	public static String getSubOrganCode(String organCode){
		if(organCode.length()==12){
			if("0000000000".equals(organCode.substring(2, 12))){//省局登陆
				organCode = organCode.substring(0, 2);
			}else if("00000000".equals(organCode.substring(4, 12))){//市局
				organCode = organCode.substring(0, 4);
			}else if("000000".equals(organCode.substring(6, 12))){//分局（县）
				organCode = organCode.substring(0, 6);
			}else if("000".equals(organCode.substring(9, 12))){//街道
				organCode = organCode.substring(0, 9);
			}
			}
		return organCode;
	}

	public static String getsjOrganCode(String subOrganCode){
		String  organId=	GetBspInfo.getBspInfo(CommandContext.getRequest()).getDepartmentOrganId();
		String organCode =IOrgan.getOrganByOrganId(organId).getOrganCode();
		if(subOrganCode.length()<=9){
			if(subOrganCode.length()==2){
				organCode=subOrganCode+"9999999999";
			}else if(subOrganCode.length()==4){
				organCode=subOrganCode+"99999999";
			}else if(subOrganCode.length()==6){
				organCode=subOrganCode+"999999";
			}else if(subOrganCode.length()==9){
				organCode=subOrganCode+"999";
			}
		}
		return organCode;
	}


}