package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomMeeting;
import com.inspur.cams.sorg.manage.domain.ISomGroupDomain;
/**
 * 会费标准备案保存和修改
 * @author Jiangzhaobao
 *
 * @date 2011年5月13日16:07:40
 */
public class SomGroupFeeCmd extends BaseAjaxCommand{
	private ISomGroupDomain service = ScaComponentFactory.getService(ISomGroupDomain.class, "somGroupDomain/somGroupDomain");
	//插入
	public void insertFee(){
		Record record=(Record)getParameter("somFee");
		SomMeeting dataBean =(SomMeeting)record.toBean(SomMeeting.class);	
	
		service.insertFee(dataBean);		
	}		
	//更新
	public void updateFee(){
		Record record=(Record)getParameter("somFee");
		SomMeeting dataBean =(SomMeeting)record.toBean(SomMeeting.class);	
		service.updateFee(dataBean);				
	}
}
