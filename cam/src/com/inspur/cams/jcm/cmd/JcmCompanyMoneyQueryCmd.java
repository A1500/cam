package com.inspur.cams.jcm.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.jcm.domain.IJcmCompanyMoneyDomain;

/**
 * 工作经费信息查询cmd
 * @author 
 * @date 2014-05-16
 */
public class JcmCompanyMoneyQueryCmd extends BaseQueryCommand {

	private IJcmCompanyMoneyDomain jcmCompanyMoneyDomain = ScaComponentFactory
			.getService(IJcmCompanyMoneyDomain.class, "jcmCompanyMoneyDomain/jcmCompanyMoneyDomain");
	
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		return jcmCompanyMoneyDomain.query(pset);
	}
	/**
	 * 单位各年度工作经费
	 * */
	public DataSet analysisMoney() {
		ParameterSet pset = getParameterSet();
		return jcmCompanyMoneyDomain.analysisMoney(pset);
	}
	/**
	 * 各单位同年度工作经费
	 * */
	public DataSet analysisMoney1() {
		ParameterSet pset = getParameterSet();
		return jcmCompanyMoneyDomain.analysisMoney1(pset);
	}
}