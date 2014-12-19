package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomOffice;
import com.inspur.cams.sorg.manage.domain.ISomUngovDomain;

public class SomUngovOfficeCmd extends BaseAjaxCommand{
	private ISomUngovDomain service = ScaComponentFactory.getService(ISomUngovDomain.class, "somUngovDomain/somUngovDomain");

	//插入
	public void insertOffice(){
		Record record=(Record)getParameter("somOffice");
		SomOffice dataBean =(SomOffice)record.toBean(SomOffice.class);
		
		service.insertOffice(dataBean);		
	}		
	//更新
	public void updateOffice(){
		Record record=(Record)getParameter("somOffice");
		SomOffice dataBean =(SomOffice)record.toBean(SomOffice.class);	
		service.updateOffice(dataBean);				
	}
}
