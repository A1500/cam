package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomOffice;
import com.inspur.cams.sorg.manage.domain.ISomGroupDomain;
/**
 * 办事机构备案保存和修改
 * @author Jiangzhaobao
 *
 * @date 2011年5月13日16:07:50
 */
public class SomGroupOfficeCmd extends BaseAjaxCommand{

	private ISomGroupDomain service = ScaComponentFactory.getService(ISomGroupDomain.class, "somGroupDomain/somGroupDomain");

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
