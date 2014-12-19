package com.inspur.cams.drel.sam.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.sam.domain.ISamIdCardDomain;

/**
 * @title:身份代码cmd
 * @description:
 * @author:zhangjian
 * @since:2011-06-18
 * @version:1.0
 */
public class SamIdCardCmd extends BaseAjaxCommand {
	private ISamIdCardDomain service = ScaComponentFactory.getService(ISamIdCardDomain.class, "samIdCardDomain/samIdCardDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return service.query(pset);
	}

	public void getIdCard() {
		String sex = (String) getParameter("sex");	
		String birthday = (String) getParameter("birthday");	
		setReturn("idCard", service.getIdCard(sex, birthday));
	}
}