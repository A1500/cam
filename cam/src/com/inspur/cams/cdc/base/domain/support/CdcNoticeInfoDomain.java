package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcNoticeInfoDao;
import com.inspur.cams.cdc.base.data.CdcNoticeInfo;
import com.inspur.cams.cdc.base.domain.ICdcNoticeInfoDomain;

public class CdcNoticeInfoDomain implements ICdcNoticeInfoDomain {
	@Reference
	private ICdcNoticeInfoDao cdcNoticeInfoDao;
	
	public DataSet query(ParameterSet pset) {
		return cdcNoticeInfoDao.query(pset);
	}
	
	public void insert(CdcNoticeInfo cdcNoticeInfo) {
		cdcNoticeInfoDao.insert(cdcNoticeInfo);
	}
	
	public void delete(CdcNoticeInfo cdcNoticeInfo) {
		cdcNoticeInfoDao.delete(cdcNoticeInfo);
	}
	
	public void delete(String noticeId) {
		cdcNoticeInfoDao.delete(noticeId);
	}
	
	public void update(CdcNoticeInfo cdcNoticeInfo) {
		cdcNoticeInfoDao.update(cdcNoticeInfo);
	}
	
	
	/**
	 * 查询下属的申报
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryReport(ParameterSet pset){
		return cdcNoticeInfoDao.queryReport(pset);
	}
	
	/**
	 * 查询上司的通知
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryNotice(ParameterSet pset){
		return cdcNoticeInfoDao.queryNotice(pset);
	}
	/**
	 * 查询自己的申报
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryMyReport(ParameterSet pset){
		return cdcNoticeInfoDao.queryMyReport(pset);
	}
	
	/**
	 * 查询自己的通知
	 * @param pset
	 * @return DataSet
	 */
	public DataSet queryMyNotice(ParameterSet pset){
		return cdcNoticeInfoDao.queryMyNotice(pset);
	}
}
