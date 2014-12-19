package com.inspur.cams.drel.surey.comm.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.surey.comm.data.SamSureyWf;

/**
 * @title:ISamSureyWfDao
 * @description:
 * @author:
 * @since:2011-09-29
 * @version:1.0
*/
 public interface ISamSureyWfDao extends BaseCURD<SamSureyWf>{
	public void save(List<SamSureyWf> list);
	public DataSet queryWf(ParameterSet pset);
	public DataSet extStatsReport(ParameterSet pset);
	public DataSet statsReport(ParameterSet pset);
	public String queryPeopleId(String sureyId);
	public String queryOrganNameByArea(String organArea);
	/**
	 *根据行政区划代码获取经济核对中心
	 * @param organArea
	 * @return
	 */
	public String queryCenterNameByArea(String organArea);
	public DataSet queryWfHisAndResult(ParameterSet pset);
}

