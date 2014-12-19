package com.inspur.cams.sorg.manage.cmd;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.data.SomAccount;
import com.inspur.cams.sorg.manage.domain.ISomFundDomain;
/**
 * 基金会账户保存，更新操作
 * @author Jiangzhaobao
 *
 * @date 2011-5-24
 */
public class SomFundAccountCmd extends BaseAjaxCommand{
	private ISomFundDomain service = ScaComponentFactory.getService(ISomFundDomain.class, "somFundDomain/somFundDomain");
	
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
	/**
	 *  根据账户查询社会组织ID
	 * @return
	 */
	public String forQuery(){
		//System.out.println("in SomFundAccountCmd");
		ParameterSet pset = getParameterSet();
		String idString2=service.queryAccountForQuery(pset);
		setReturn("idString2", idString2);
		return "";	
	}
}
