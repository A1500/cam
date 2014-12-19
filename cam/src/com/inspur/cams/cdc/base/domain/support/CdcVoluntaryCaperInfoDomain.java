package com.inspur.cams.cdc.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcVoluntaryCaperInfoDao;
import com.inspur.cams.cdc.base.data.CdcVoluntaryCaperInfo;
import com.inspur.cams.cdc.base.domain.ICdcVoluntaryCaperInfoDomain;

/**
 * 志愿者参加活动信息domain
 * 
 * @author
 * @date 2013-02-26
 */
public class CdcVoluntaryCaperInfoDomain implements ICdcVoluntaryCaperInfoDomain {

	@Reference
	private ICdcVoluntaryCaperInfoDao cdcVoluntaryCaperInfoDao;

	/**
	 * 查询 志愿者参加活动信息
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcVoluntaryCaperInfoDao.query(pset);
	}

	/**
	 * 获取 志愿者参加活动信息
	 * 
	 * @param pset
	 * @return
	 */
	public CdcVoluntaryCaperInfo get(String recordId) {
		return cdcVoluntaryCaperInfoDao.get(recordId);
	}

	/**
	 * 增加 志愿者参加活动信息
	 * 
	 * @param cdcVoluntaryCaperInfo
	 */
	public void insert(CdcVoluntaryCaperInfo cdcVoluntaryCaperInfo) {
		cdcVoluntaryCaperInfoDao.insert(cdcVoluntaryCaperInfo);
	}

	/**
	 * 修改 志愿者参加活动信息
	 * 
	 * @param cdcVoluntaryCaperInfo
	 */
	public void update(CdcVoluntaryCaperInfo cdcVoluntaryCaperInfo) {
		cdcVoluntaryCaperInfoDao.update(cdcVoluntaryCaperInfo);
	}

	/**
	 * 删除 志愿者参加活动信息
	 * 
	 * @param recordId
	 */
	public void delete(String recordId) {
		cdcVoluntaryCaperInfoDao.delete(recordId);
	}

	public void batchInsert(List<CdcVoluntaryCaperInfo> cdcVoluntaryCaperInfoList) {
		cdcVoluntaryCaperInfoDao.batchInsert(cdcVoluntaryCaperInfoList);
	}
	public void batchUpdate(List<CdcVoluntaryCaperInfo> cdcVoluntaryCaperInfoList) {
		cdcVoluntaryCaperInfoDao.batchUpdate(cdcVoluntaryCaperInfoList);
	}
	public void save(List<CdcVoluntaryCaperInfo> cdcVoluntaryCaperInfoList) {
		cdcVoluntaryCaperInfoDao.save(cdcVoluntaryCaperInfoList);
	}
	
	/**
	 * @Description: 删除活动下的所有关系
	 * @author xuexzh
	 */
	public void deleteByCaper(String caperId) {
		cdcVoluntaryCaperInfoDao.deleteByCaper(caperId);
	}
}