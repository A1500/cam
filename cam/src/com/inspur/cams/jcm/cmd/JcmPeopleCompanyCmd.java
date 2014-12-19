package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.inspur.cams.jcm.data.JcmPeopleCompany;
import com.inspur.cams.jcm.domain.IJcmPeopleCompanyDomain;

/**
 * 人员工作单位信息（多条记录过程）cmd
 * @author 
 * @date 2014-05-16
 */
public class JcmPeopleCompanyCmd extends BaseAjaxCommand {
	
	private IJcmPeopleCompanyDomain jcmPeopleCompanyDomain = ScaComponentFactory
			.getService(IJcmPeopleCompanyDomain.class, "jcmPeopleCompanyDomain/jcmPeopleCompanyDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		JcmPeopleCompany jcmPeopleCompany = (JcmPeopleCompany) record.toBean(JcmPeopleCompany.class);
		jcmPeopleCompanyDomain.insert(jcmPeopleCompany);
		
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		JcmPeopleCompany jcmPeopleCompany = (JcmPeopleCompany) record.toBean(JcmPeopleCompany.class);
		jcmPeopleCompanyDomain.update(jcmPeopleCompany);
	}
	
	// 删除
	public void delete() {
		String peopleCompanyId = (String) getParameter("peopleCompanyId");
		jcmPeopleCompanyDomain.delete(peopleCompanyId);
	}
	
}