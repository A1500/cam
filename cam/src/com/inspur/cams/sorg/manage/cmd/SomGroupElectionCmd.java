package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomMeeting;
import com.inspur.cams.sorg.manage.domain.ISomGroupDomain;

public class SomGroupElectionCmd extends BaseAjaxCommand{
	private ISomGroupDomain service = ScaComponentFactory.getService(ISomGroupDomain.class, "somGroupDomain/somGroupDomain");
	
	//插入
	public void insertElection(){
		Record record=(Record)getParameter("somElection");
		String electionDate=(String)getParameter("electionDate");
		Integer electionPeriod=new Integer((String)getParameter("electionPeriod"));
		String sorgId=(String)getParameter("sorgId");
		SomMeeting dataBean =(SomMeeting)record.toBean(SomMeeting.class);	
		service.insertElection(dataBean,electionDate,electionPeriod,sorgId);		
	}		
	//更新
	public void updateElection(){
		Record record=(Record)getParameter("somElection");
		Integer electionPeriod = new Integer((String) getParameter("electionPeriod"));
		SomMeeting dataBean =(SomMeeting)record.toBean(SomMeeting.class);	
		service.updateElection(dataBean,electionPeriod);				
	}
}