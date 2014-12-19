package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomAccount;
import com.inspur.cams.sorg.manage.domain.ISomUngovDomain;

public class SomUngovAccountCmd extends BaseAjaxCommand{
	private ISomUngovDomain service = ScaComponentFactory.getService(ISomUngovDomain.class, "somUngovDomain/somUngovDomain");
	//插入
	public void insertAccount(){
		Record record=(Record)getParameter("somAccount");
		SomAccount dataBean =(SomAccount)record.toBean(SomAccount.class);

		service.insertAccount(dataBean);		
	}		
	//更新
	public void updateAccount(){
		Record record=(Record)getParameter("somAccount");
		SomAccount dataBean =(SomAccount)record.toBean(SomAccount.class);	
		service.updateAccount(dataBean);				
	}
	
}
