package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.data.JcmCompanyMoney;
import com.inspur.cams.jcm.domain.IJcmCompanyMoneyDomain;

/**
 * 工作经费信息cmd
 * @author 
 * @date 2014-05-16
 */
public class JcmCompanyMoneyCmd extends BaseAjaxCommand {

	private IJcmCompanyMoneyDomain jcmCompanyMoneyDomain = ScaComponentFactory
			.getService(IJcmCompanyMoneyDomain.class, "jcmCompanyMoneyDomain/jcmCompanyMoneyDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		JcmCompanyMoney jcmCompanyMoney = (JcmCompanyMoney) record.toBean(JcmCompanyMoney.class);
		jcmCompanyMoneyDomain.insert(jcmCompanyMoney);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		JcmCompanyMoney jcmCompanyMoney = (JcmCompanyMoney) record.toBean(JcmCompanyMoney.class);
		jcmCompanyMoneyDomain.update(jcmCompanyMoney);
	}
	
	// 删除
	public void delete() {
		String companyMoneyId = (String) getParameter("companyMoneyId");
		jcmCompanyMoneyDomain.delete(companyMoneyId);
	}
	
}