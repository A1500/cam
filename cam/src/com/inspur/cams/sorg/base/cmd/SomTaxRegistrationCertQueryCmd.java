package com.inspur.cams.sorg.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.base.domain.ISomTaxRegistrationCertDomain;

/**
 * 税务登记证备案查询
 * 
 * @author zhangjian
 * @date 2011-12-12
 */
public class SomTaxRegistrationCertQueryCmd extends BaseQueryCommand {

	private ISomTaxRegistrationCertDomain somTaxRegistrationCertDomain = ScaComponentFactory
			.getService(ISomTaxRegistrationCertDomain.class,
					"somTaxRegistrationCertDomain/somTaxRegistrationCertDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return somTaxRegistrationCertDomain.query(pset);
	}
}
