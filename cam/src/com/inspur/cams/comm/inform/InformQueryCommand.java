package com.inspur.cams.comm.inform;

import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.bsp.share.organization.OrganFactory;
import org.loushang.bsp.share.organization.provider.IOrganProvider;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.next.web.cmd.CommandContext;



/**
 * @title:InformQueryCommand
 * @description:执行通知相关查询操作
 * @author:tianbaoyun
 * @since:2009-10-27
 * @version:1.0
 */
public class InformQueryCommand extends BaseQueryCommand {
	private static IOrganProvider IOrgan=(IOrganProvider)OrganFactory.getIOrganProvider();

	/**
	 * @description:处理发件箱查询操作,显示发送者是当前用户的所有记录。
	 * @author huangqiqing
	 * @return DataSet
	 * @since 2009-10-28
	 */

	@SuppressWarnings("unchecked")
	public DataSet querySendBox() {
		ParameterSet pset = getParameterSet();
		String sendmanId = (String) pset.getParameter("sendmanIdquery");
		if(sendmanId==null||"null".equals(sendmanId)){
			sendmanId = "";
		}
		String title =  (String) pset.getParameter("titlequery");
		if(title==null||"null".equals(title)){
			title = "";
		}
		String organCode = getCurrentUserOrganCode();
		int start = pset.getPageStart();
		int limit = pset.getPageLimit();
		InformDao informdao = (InformDao) DaoFactory.getDao("com.inspur.cams.comm.inform.InformDao");
		return informdao.querySendBox(organCode,title,sendmanId,start,limit);

	}

	/**
	 * @description:处理收件箱查询操作，显示收件人是当前用户或者收件人是当前用户所在部门，并且状态是”有效“的记录。
	 * @author huangqiqing
	 * @return DataSet
	 * @throws Exception
	 * @since 2009-11-12
	 */
	public DataSet queryReceiveBox(){
		//准备查询条件
		ParameterSet pset = getParameterSet();
		String isRead = (String) pset.getParameter("isRead");
		if(isRead==null||"null".equals(isRead)){
			isRead = "";
		}
		String sendmanId = (String) pset.getParameter("sendmanIdquery");
		if(sendmanId==null||"null".equals(sendmanId)){
			sendmanId = "";
		}
		String title =  (String) pset.getParameter("titlequery");
		if(title==null||"null".equals(title)){
			title = "";
		}
		String organCode = getCurrentUserOrganCode();
		int start = pset.getPageStart();
		int limit = pset.getPageLimit();
		InformDao informdao = (InformDao) DaoFactory.getDao("com.inspur.cams.comm.inform.InformDao");
		DataSet informDs=informdao.queryReceiveBox(title,sendmanId,isRead,start,limit);
		StringBuffer sb=new StringBuffer();
		for(int i=0;i<informDs.getCount();i++){
			Record record=informDs.getRecord(i);
			String receiveMan=(String)record.get("RECEIVEMAN")==null?"":(String)record.get("RECEIVEMAN");
			String id=(String)record.get("ID")==null?"":(String)record.get("ID");
			String[] receiveMans= receiveMan.split(",");

			for(int j=0;j<receiveMans.length;j++){
				if(organCode.equals(receiveMans[j])){
					sb.append(id).append(",");
				}
			}

		}
		DataSet ds=new DataSet();
		if(sb.toString().length()>0){
			String ids=sb.toString().substring(0, sb.toString().length()-1);
		    ds=informdao.queryByIds(ids, start, limit);
		}
		return ds;
	}
	/**
	 * @description:返回当前登陆用户所在部门编号
	 * @author huangqiqing
	 * @return String
	 * @since 2009-11-11
	 */
	public String getCurrentUserOrganCode(){
		String  organId=	GetBspInfo.getBspInfo(CommandContext.getRequest()).getDepartmentOrganId();
		String cantCode =IOrgan.getOrganByOrganId(organId).getOrganCode();
		return cantCode;
	}
}
