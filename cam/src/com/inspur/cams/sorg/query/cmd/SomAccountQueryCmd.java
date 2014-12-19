package com.inspur.cams.sorg.query.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.sorg.query.domain.ISomAccountQueryDomain;

public class SomAccountQueryCmd extends BaseQueryCommand {
	private ISomAccountQueryDomain service = ScaComponentFactory.getService(ISomAccountQueryDomain.class,"somAccountQueryDomain/somAccountQueryDomain");

	/**
	 * 查询社团台帐
	 * 
	 * @return
	 */
	public DataSet queryGroupAccount() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryGroupAccount(pset);
		return ds;
	}

	/**
	 * 查询民非台帐
	 * 
	 * @return
	 */
	public DataSet queryUngovAccount() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryUngovAccount(pset);
		return ds;
	}

	/**
	 * 查询基金会台帐
	 * 
	 * @return
	 */
	public DataSet queryFundAccount() {
		ParameterSet pset = getParameterSet();
		DataSet ds = service.queryFundAccount(pset);
		return ds;
	}
}
