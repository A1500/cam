package com.inspur.cams.sorg.query.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.data.SomOrgan;

public interface ISomAccountQueryDao extends BaseCURD<SomOrgan> {

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
