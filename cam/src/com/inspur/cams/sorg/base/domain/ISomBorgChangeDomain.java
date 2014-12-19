package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomBorgChange;

/**
 * 业务主管单位变更domain接口
 */
public interface ISomBorgChangeDomain {
	
	public DataSet query(ParameterSet pset);
	/**
	 * 查询数量
	 * @param pset
	 * @return
	 */
	public int queryCount(ParameterSet pset);
	
	/**
	 * 查询变更数量
	 * @param pset
	 * @return
	 */
	public DataSet queryBeforeCount(ParameterSet pset);
	
	/**
	 * 业务主管单位变更历史
	 */
	public DataSet showChange(ParameterSet pset);
	
	/**
	 * 当前业务主管单位名称
	 * @param pset
	 * @return
	 */
	public String nowBorgName(ParameterSet pset);

	@Trans
	public void insert(SomBorgChange somBorgChange);
}
