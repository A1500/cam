package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomEntity;
import com.inspur.cams.sorg.manage.domain.ISomFundDomain;

public class SomFundEntityCmd extends BaseAjaxCommand{
	private ISomFundDomain service = ScaComponentFactory.getService(ISomFundDomain.class, "somFundDomain/somFundDomain");
	
	//插入
	public void insertEntity(){
		Record record=(Record)getParameter("somEntity");
		SomEntity dataBean =(SomEntity)record.toBean(SomEntity.class);	

		service.insertEntity(dataBean);		
	}		
	//更新
	public void updateEntity(){
		Record record=(Record)getParameter("somEntity");
		SomEntity dataBean =(SomEntity)record.toBean(SomEntity.class);	
		service.updateEntity(dataBean);				
	}
}
