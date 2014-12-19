package com.inspur.cams.sorg.query.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.query.data.SomWorkflowQuery;

public interface ISomWorkflowQueryDao extends BaseCURD<SomWorkflowQuery>{

	/**
	 * 按照日期查询 已办理过的业务数量
	 * @param pset
	 * @return
	 */
	public DataSet queryNum(ParameterSet pset);
	
	/**
	 * 按照日期查询 已办理过的指定业务对应的所有社会组织列表
	 * @return
	 */
	public DataSet queryList(ParameterSet pset);
	
	/**
	 * 按照日期查询 已办理过的业务中指定的社会组织对应的所有环节情况
	 * @return
	 */
	public DataSet queryDetail(ParameterSet pset);
}
