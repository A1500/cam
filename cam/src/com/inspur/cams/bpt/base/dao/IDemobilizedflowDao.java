package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.Demobilizedflow;

/**
 * @title:IDemobilizedflowDao
 * @description:
 * @author:
 * @since:2011-07-29
 * @version:1.0
*/
 public interface IDemobilizedflowDao extends BaseCURD<Demobilizedflow>{
	public void save(List<Demobilizedflow> list);

	public DataSet queryDemobilized(ParameterSet pset);

	public DataSet query1(ParameterSet pset);

	public void updateFlow(Demobilizedflow demobilizedflowDevices);

	public void updateExchaCertiDemo(Demobilizedflow dateBean);
	public void deleteDemobilized (ParameterSet pset);
	public void deleteDemobilizedIll (ParameterSet pset);
}

