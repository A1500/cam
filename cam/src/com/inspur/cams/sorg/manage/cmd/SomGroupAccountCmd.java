package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomAccount;
import com.inspur.cams.sorg.manage.domain.ISomGroupDomain;
/**
 * 账户备案保存和修改
 * @author Jiangzhaobao
 *
 * @date 2011年5月13日16:07:10
 */
public class SomGroupAccountCmd extends BaseAjaxCommand{	
	
	private ISomGroupDomain service = ScaComponentFactory.getService(ISomGroupDomain.class, "somGroupDomain/somGroupDomain");
	
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
