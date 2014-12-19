package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.data.JcmCompanyHis;
import com.inspur.cams.jcm.domain.IJcmCompanyHisDomain;

/**
 * 单位历史信息cmd
 * @author 
 * @date 2014-05-16
 */
public class JcmCompanyHisCmd extends BaseAjaxCommand {

	private IJcmCompanyHisDomain jcmCompanyHisDomain = ScaComponentFactory
			.getService(IJcmCompanyHisDomain.class, "jcmCompanyHisDomain/jcmCompanyHisDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		JcmCompanyHis jcmCompanyHis = (JcmCompanyHis) record.toBean(JcmCompanyHis.class);
		jcmCompanyHisDomain.insert(jcmCompanyHis);
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		JcmCompanyHis jcmCompanyHis = (JcmCompanyHis) record.toBean(JcmCompanyHis.class);
		jcmCompanyHisDomain.update(jcmCompanyHis);
	}
	
	// 删除
	public void delete() {
		String companyId = (String) getParameter("companyId");
		jcmCompanyHisDomain.delete(companyId);
	}
	
}