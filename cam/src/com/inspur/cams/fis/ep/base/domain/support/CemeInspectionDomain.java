package com.inspur.cams.fis.ep.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.fis.ep.base.dao.ICemeInspectionDao;
import com.inspur.cams.fis.ep.base.dao.IFisCemeAccessoriesDao;
import com.inspur.cams.fis.ep.base.dao.IFisCemeCheckAuditDao;
import com.inspur.cams.fis.ep.base.dao.IFisCemeCheckResultDao;
import com.inspur.cams.fis.ep.base.dao.IFisCemeCheckScoreDao;
import com.inspur.cams.fis.ep.base.dao.IFisCemeDao;
import com.inspur.cams.fis.ep.base.data.CemeInspection;
import com.inspur.cams.fis.ep.base.data.FisCemeAccessories;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckAudit;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckResult;
import com.inspur.cams.fis.ep.base.data.FisCemeCheckScore;
import com.inspur.cams.fis.ep.base.domain.ICemeInspectionDomain;

/**
 * @title:InspectionDomain
 * @description:公墓年检表单domain
 * @author:lidongdong
 * @since:2011-11-17
 * @version:1.0
 */
public class CemeInspectionDomain implements ICemeInspectionDomain {

	private ICemeInspectionDao cemeinspectionDao;

	private IFisCemeCheckResultDao cemeCheckResultDao;
	
	private IFisCemeAccessoriesDao	cemeAccessoriesDao;
	
	private IFisCemeCheckAuditDao cemeCheckAuditDao;
	
	private IFisCemeCheckScoreDao cemeCheckScoreDao;
	
	private IFisCemeDao cemeDao;

	@Reference
	public void setCemeCheckScoreDao(IFisCemeCheckScoreDao cemeCheckScoreDao) {
		this.cemeCheckScoreDao = cemeCheckScoreDao;
	}

	@Reference
	public void setCemeCheckAuditDao(IFisCemeCheckAuditDao cemeCheckAuditDao) {
		this.cemeCheckAuditDao = cemeCheckAuditDao;
	}

	@Reference
	public void setCemeAccessoriesDao(IFisCemeAccessoriesDao cemeAccessoriesDao) {
		this.cemeAccessoriesDao = cemeAccessoriesDao;
	}

	@Reference
	public void setCemeDao(IFisCemeDao cemeDao) {
		this.cemeDao = cemeDao;
	}

	@Reference
	public void setCemeCheckResultDao(IFisCemeCheckResultDao cemeCheckResultDao) {
		this.cemeCheckResultDao = cemeCheckResultDao;
	}
	

	@Reference
	public void setcemeInspectionDao(ICemeInspectionDao cemeinspectionDao) {
		this.cemeinspectionDao = cemeinspectionDao;
	}


	public DataSet query(ParameterSet pset) {
		String id = (String) pset.getParameter("CEME_ID");
		if((id!=null)&&(!"null".equals(id))){
			DataSet ds = cemeDao.query(pset);
			return ds;
		}
		DataSet ds = cemeinspectionDao.query(pset);
		return ds ;
	}


	public FisCemeCheckResult getResult(String resultId) {
		return cemeCheckResultDao.get(resultId);
	}

	public void updateResult(FisCemeCheckResult result) {
		cemeCheckResultDao.update(result);
	}


	public void insert(FisCemeCheckResult result) {
		cemeCheckResultDao.insert(result);
	}

	public DataSet queryAccessories(ParameterSet pset) {
		return cemeAccessoriesDao.queryAccessories(pset);
	}
	
	public DataSet queryScore(ParameterSet pset) {
		return cemeCheckScoreDao.query(pset);
	}

	public void uploadSave(List<FisCemeAccessories> list) {
		cemeAccessoriesDao.batchInsert(list);
	}

	public DataSet queryAccessoriesItem(ParameterSet pset) {
		return cemeAccessoriesDao.queryAccessoriesItem(pset);
	}

	public void delAccessoriesById(String id) {
		cemeAccessoriesDao.delete(id);
	}

	public void updateInfo(CemeInspection info) {
		cemeinspectionDao.update(info);
	}

	public void updateAudit(FisCemeCheckAudit audit) {
		cemeCheckAuditDao.update(audit);
	}

	public void save(CemeInspection info, FisCemeCheckAudit audit,
			FisCemeCheckScore score) {
		cemeinspectionDao.insert(info);
		cemeCheckAuditDao.insert(audit);
		cemeCheckScoreDao.insert(score);
	}

	public DataSet queryAudit(ParameterSet pset) {
		return cemeCheckAuditDao.query(pset);
	}

}