package com.inspur.cams.drel.surey.comm.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.surey.assistance.data.SamSureyAssistanceResult;
import com.inspur.cams.drel.surey.assistance.data.SamSureyWfAssistanceHis;
import com.inspur.cams.drel.surey.comm.data.SamSurey;
import com.inspur.cams.drel.surey.comm.data.SamSureyWf;
import com.inspur.cams.drel.surey.comm.data.SamSureyWfHis;

public interface ISamSureyWfDomain {
	public DataSet queryWf(ParameterSet pset);
	
	public DataSet extStatsReport(ParameterSet pset);
	
	public DataSet statsReport(ParameterSet pset);
	
	public DataSet initialQuery(ParameterSet pset);
	
	public void insert(SamSureyWf bean);
	
	public void update(SamSureyWf bean);
	
	public void insertSureyWfHis(SamSureyWfHis bean);
	
	public void insertSureyWfAssistanceHis(SamSureyWfAssistanceHis bean);
	
	public DataSet querySamSurey(ParameterSet pset);
	
	public void updateSamSurey(SamSurey bean);
	
	public DataSet querySureyWfHis(ParameterSet pset);
	
	public DataSet queryAssistanceHis(ParameterSet pset);
	
	public void insertAssistanceResult(SamSureyAssistanceResult bean);
	
	public String queryPeopleId(String sureyId);
	
	public void updateSamSureyWfHis(SamSureyWfHis bean);
	
	public String getOrganName(String organArea);
	/**
	 * 获取经济核对中心
	 * @param organArea
	 * @return
	 */
	public String getCenterName(String organArea);
	public DataSet queryWfHisAndResult(ParameterSet pset);
}
