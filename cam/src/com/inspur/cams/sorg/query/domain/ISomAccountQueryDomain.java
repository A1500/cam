package com.inspur.cams.sorg.query.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

public interface ISomAccountQueryDomain {
	/**
	 * 查询社团台帐
	 * 
	 * @return
	 */
	public DataSet queryGroupAccount(ParameterSet pset);

	/**
	 * 查询民非台帐
	 * 
	 * @return
	 */
	public DataSet queryUngovAccount(ParameterSet pset);

	/**
	 * 查询基金会台帐
	 * 
	 * @return
	 */
	public DataSet queryFundAccount(ParameterSet pset);
}
