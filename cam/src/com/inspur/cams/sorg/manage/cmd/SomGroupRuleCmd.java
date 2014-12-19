package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomMeeting;
import com.inspur.cams.sorg.manage.domain.ISomGroupDomain;
/**
 * 章程备案保存和修改
 * @author Jiangzhaobao
 *
 * @date 2011年5月13日16:08:04
 */
public class SomGroupRuleCmd extends BaseAjaxCommand{
	private ISomGroupDomain service = ScaComponentFactory.getService(ISomGroupDomain.class, "somGroupDomain/somGroupDomain");
	
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
