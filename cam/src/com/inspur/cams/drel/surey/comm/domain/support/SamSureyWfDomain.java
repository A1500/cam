package com.inspur.cams.drel.surey.comm.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.surey.assistance.dao.ISamSureyAssistanceResultDao;
import com.inspur.cams.drel.surey.assistance.dao.ISamSureyWfAssistanceHisDao;
import com.inspur.cams.drel.surey.assistance.data.SamSureyAssistanceResult;
import com.inspur.cams.drel.surey.assistance.data.SamSureyWfAssistanceHis;
import com.inspur.cams.drel.surey.comm.dao.ISamSureyDao;
import com.inspur.cams.drel.surey.comm.dao.ISamSureyWfDao;
import com.inspur.cams.drel.surey.comm.dao.ISamSureyWfHisDao;
import com.inspur.cams.drel.surey.comm.data.SamSurey;
import com.inspur.cams.drel.surey.comm.data.SamSureyWf;
import com.inspur.cams.drel.surey.comm.data.SamSureyWfHis;
import com.inspur.cams.drel.surey.comm.domain.ISamSureyWfDomain;

public class SamSureyWfDomain implements ISamSureyWfDomain {
	@Reference
	ISamSureyWfDao samSureyWfDao ;
	@Reference
	ISamSureyDao samSureyDao;
	@Reference
	ISamSureyWfHisDao samSureyWfHisDao;
	@Reference
	ISamSureyWfAssistanceHisDao samSureyWfAssistanceHisDao;
	@Reference
	ISamSureyAssistanceResultDao samSureyAssistanceResultDao;

	public DataSet queryWf(ParameterSet pset) {
		return samSureyWfDao.queryWf(pset);
	}
	public DataSet extStatsReport(ParameterSet pset) {
		return samSureyWfDao.extStatsReport(pset);
	}
	public DataSet statsReport(ParameterSet pset) {
		return samSureyWfDao.statsReport(pset);
	}
	public DataSet initialQuery(ParameterSet pset) {
		return samSureyWfDao.query(pset);
	}

	
	public void insert(SamSureyWf bean) {
		samSureyWfDao.insert(bean);
		
	}

	public void update(SamSureyWf bean) {
		samSureyWfDao.update(bean);
	}

	public void insertSureyWfHis(SamSureyWfHis bean) {
		samSureyWfHisDao.insert(bean);
	}

	public void insertSureyWfAssistanceHis(SamSureyWfAssistanceHis bean) {
		samSureyWfAssistanceHisDao.insert(bean);
		
	}

	public DataSet querySamSurey(ParameterSet pset) {
		return samSureyDao.query(pset);
	}

	public void updateSamSurey(SamSurey bean) {
		samSureyDao.update(bean);
	}

	public DataSet querySureyWfHis(ParameterSet pset) {
		return samSureyWfHisDao.query(pset);
	}

	public DataSet queryAssistanceHis(ParameterSet pset) {
		return samSureyWfAssistanceHisDao.query(pset);
	}

	public void insertAssistanceResult(SamSureyAssistanceResult bean) {
		samSureyAssistanceResultDao.insert(bean);
	}

	public String queryPeopleId(String sureyId) {
		return samSureyWfDao.queryPeopleId(sureyId);
	}

	public void updateSamSureyWfHis(SamSureyWfHis bean) {
		samSureyWfHisDao.update(bean);
	}
	public DataSet queryWfHisAndResult(ParameterSet pset){
		return samSureyWfDao.queryWfHisAndResult(pset);
	}
	
	/**
	 * 根据行政区划获取单位名称
	 * @param organArea
	 * @return
	 */
	public String getOrganName(String organArea){
		return samSureyWfDao.queryOrganNameByArea(organArea);
	}
	/**
	 * 根据经济核对中心
	 * @param organArea
	 * @return
	 */
	public String getCenterName(String organArea){
		return samSureyWfDao.queryCenterNameByArea(organArea);
	}
}
