package com.inspur.cams.cdc.base.dao;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

/**
 * 民主选举汇总查询Dao
 * @author shgtch
 * @date 2012-12-24
 */
public interface ICdcElectionSumDao {

	public DataSet query(ParameterSet pset);

	public DataSet queryByParentCode(ParameterSet pset);

}