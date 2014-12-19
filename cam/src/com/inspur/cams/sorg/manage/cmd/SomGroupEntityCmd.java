package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomEntity;
import com.inspur.cams.sorg.manage.domain.ISomGroupDomain;
/**
 * 举办实体备案保存和修改
 * @author Jiangzhaobao
 *
 * @date 2011年5月13日16:07:27
 */
public class SomGroupEntityCmd extends BaseAjaxCommand{
	private ISomGroupDomain service = ScaComponentFactory.getService(ISomGroupDomain.class, "somGroupDomain/somGroupDomain");
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
