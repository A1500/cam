package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.domain.ISomSessionDomain;

/**
 * 社会组织届次查询cmd
 * @author shgtch
 * @date 2011-9-22
 */
public class SomSessionQueryCmd extends BaseQueryCommand {

	ISomSessionDomain somSessionDomain = ScaComponentFactory.getService(ISomSessionDomain.class, "somSessionDomain/somSessionDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somSessionDomain.query(pset);
	}
	
	public DataSet getCurrentSession() {
		String sorgId = (String) getParameter("SORG_ID");
		return somSessionDomain.getCurrentSession(sorgId);
	}
	/**
	 * 查询该登记证号的社会组织下面是否存在填写的届次名称
	 * @param sorgCode 登记证号
	 * @param sessionName  届次名称
	 * @param sorgId  sorgId
	 */
	public DataSet findIfExist(){
		String sorgCode = (String) getParameter("sorgCode");
		String sessionName = (String) getParameter("sessionName");
		String sorgId = (String) getParameter("sorgId");
		
		return somSessionDomain.findIfExist(sorgCode,sessionName,sorgId);
	}
}