package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.syscncharspell.domain.ISysCnCharSpellDomain;

/**
 * @title:BptPeopleDisabilityNameCommand
 * @description:
 * @since:2011-04-18
 * @version:1.0
 */
public class BptPeopleDisabilityNameCommand extends BaseAjaxCommand {
	
ISysCnCharSpellDomain service = ScaComponentFactory.getService(ISysCnCharSpellDomain.class, "sysCnCharSpellDomain/sysCnCharSpellDomain");
/**
 * 根据中文姓名生成拼音姓名码
 * @author SAMSUNG
 * @licb  20110904
 */
	public void getCnStr(){
		String cnStr = (String) getParameter("cnStr");//中文姓名
		String sType = (String) getParameter("sType");//传入转换类型
		String jsonString = service.getCnStrSpell(cnStr, sType);//获取姓名拼音码
		//System.out.println("CMD ENTER="+jsonString);
		
		setReturn("jsonString", jsonString);
	}

public ISysCnCharSpellDomain getService() {
	return service;
}
public void setService(ISysCnCharSpellDomain service) {
	this.service = service;
}
	 
}