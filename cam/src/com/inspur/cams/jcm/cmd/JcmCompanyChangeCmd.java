package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.data.JcmCompanyChange;
import com.inspur.cams.jcm.domain.IJcmCompanyChangeDomain;

/**
 * 单位信息调整（多条记录过程）cmd
 * @author 
 * @date 2014-05-16
 */
public class JcmCompanyChangeCmd extends BaseAjaxCommand {

	private IJcmCompanyChangeDomain jcmCompanyChangeDomain = ScaComponentFactory
			.getService(IJcmCompanyChangeDomain.class, "jcmCompanyChangeDomain/jcmCompanyChangeDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		JcmCompanyChange jcmCompanyChange = (JcmCompanyChange) record.toBean(JcmCompanyChange.class);
		jcmCompanyChangeDomain.insert(jcmCompanyChange);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		JcmCompanyChange jcmCompanyChange = (JcmCompanyChange) record.toBean(JcmCompanyChange.class);
		jcmCompanyChangeDomain.update(jcmCompanyChange);
	}
	
	// 删除
	public void delete() {
		String companyChangeId = (String) getParameter("companyChangeId");
		jcmCompanyChangeDomain.delete(companyChangeId);
	}
	
}