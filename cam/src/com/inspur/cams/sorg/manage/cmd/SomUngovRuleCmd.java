package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomMeeting;
import com.inspur.cams.sorg.manage.domain.ISomUngovDomain;

public class SomUngovRuleCmd extends BaseAjaxCommand{
	private ISomUngovDomain service = ScaComponentFactory.getService(ISomUngovDomain.class, "somUngovDomain/somUngovDomain");
	
	//插入
	public void insertRule(){
		Record record=(Record)getParameter("somRule");
		SomMeeting dataBean =(SomMeeting)record.toBean(SomMeeting.class);	
		service.insertRule(dataBean);		
	}		
	//更新
	public void updateRule(){
		Record record=(Record)getParameter("somRule");
		SomMeeting dataBean =(SomMeeting)record.toBean(SomMeeting.class);	
		service.updateRule(dataBean);				
	}
}
