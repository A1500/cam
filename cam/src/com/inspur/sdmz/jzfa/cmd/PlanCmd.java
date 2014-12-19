package com.inspur.sdmz.jzfa.cmd;

import javax.servlet.http.HttpServletRequest;

import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.sdmz.jzfa.data.Detail;
import com.inspur.sdmz.jzfa.data.Plan;
import com.inspur.sdmz.jzfa.domain.IPlanDomain;

/**
 * 救助方案Cmd
 * @author shgtch
 * @date 2011-4-16
 */
public class PlanCmd extends BaseAjaxCommand {
	
	IPlanDomain planDomain = ScaComponentFactory.getService(IPlanDomain.class, "HelpDomain/HelpService");
	
	/**
	 * 增加救助方案
	 */
	public void addJzfa() {
		Plan jzfa = (Plan) getParameter("jzfa");
		String organType=(String)getParameter("organType");
		HttpServletRequest request=(HttpServletRequest)getRequest();
		planDomain.addJzfa(jzfa,request,organType);
	}
	
	/**
	 * 更新救助方案
	 */
	public void updateJzfa() {
		Plan jzfa = (Plan) getParameter("jzfa1");
		String organType=(String)getParameter("organType");
		HttpServletRequest request=(HttpServletRequest)getRequest();
		planDomain.updateJzfa(jzfa,request,organType);
	}
	
	/**
	 * 删除救助方案
	 */
	public void deleteJzfa() {
		String[] jzfaids = (String[])getParameter("jzfaids");
		for(int i = 0; i < jzfaids.length; i++){
			planDomain.deleteJzfa(jzfaids[i]);
		}
	}
	
	/**
	 * 增加一条救助方案明细
	 */
	public void addJzfamx() {
		Detail jzfamx = (Detail) getParameter("jzfamx");
		String jzfaid=(String) getParameter("jzfaid");
		String szdxlxdm=(String) getParameter("szdxlxdm");
		String sfzh=(String) getParameter("sfzh");
		HttpServletRequest request=(HttpServletRequest)getRequest();
		String szdxId=planDomain.addJzfamx(jzfamx,jzfaid,sfzh,szdxlxdm,request);
		setReturn("szdxId",szdxId);
	}

	/**
	 * 更新一条救助方案明细
	 */
	public void updateJzfamx(){
		String szdxlxdm=(String) getParameter("szdxlxdm");
		String sfzh=(String) getParameter("sfzh");
		Detail jzfamx = (Detail) getParameter("jzfamx");
		String jzfaid=(String) getParameter("jzfaid");
		HttpServletRequest request=(HttpServletRequest)getRequest();
		String szdxId=planDomain.updateJzfamx(jzfamx,jzfaid,sfzh,szdxlxdm,request);
		setReturn("szdxId",szdxId);
	}

	/**
	 * 删除一条救助方案明细
	 */
	public void deleteJzfamx() {
		String[] jzfamxids = (String[])getParameter("jzfamxids");
		String jzfaid=(String) getParameter("jzfaid");
		for(int i = 0; i < jzfamxids.length; i++){
			planDomain.delJzje(jzfamxids[i]);
		}
		
		for(int i = 0; i < jzfamxids.length; i++){
			planDomain.deleteJzfamx(jzfamxids[i],jzfaid);
		}
		
	}
	/**
	 * 救助方案实施
	 */
	public void passJzfa() {
		String[] jzfaids=(String[]) getParameter("jzfaids");
		planDomain.passJzfa(jzfaids);
	}
	
	/**
	 * 查询受助人是否被其他方案救助
	 */
	public void ifAssisted() {
		String idCard = (String) getParameter("idCard");
		String num =  planDomain.ifAssisted(idCard);
		setReturn("num", num);
	}
}
