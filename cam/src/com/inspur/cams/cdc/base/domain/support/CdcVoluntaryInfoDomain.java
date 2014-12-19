package com.inspur.cams.cdc.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcVoluntaryInfoDao;
import com.inspur.cams.cdc.base.data.CdcVoluntaryInfo;
import com.inspur.cams.cdc.base.domain.ICdcVoluntaryInfoDomain;

/**
 * 志愿者信息domain
 * @author 
 * @date 2013-02-26
 */
public class CdcVoluntaryInfoDomain implements ICdcVoluntaryInfoDomain {

	@Reference
	private ICdcVoluntaryInfoDao cdcVoluntaryInfoDao;

	/**
	 * 查询 志愿者信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcVoluntaryInfoDao.query(pset);
	}

	/**
	 * 获取 志愿者信息
	 * @param pset
	 * @return
	 */
	public CdcVoluntaryInfo get(String voluntaryId) {
		return cdcVoluntaryInfoDao.get(voluntaryId);
	}

	/**
	 * 增加 志愿者信息
	 * @param cdcVoluntaryInfo
	 */
	public void insert(CdcVoluntaryInfo cdcVoluntaryInfo) {
		cdcVoluntaryInfoDao.insert(cdcVoluntaryInfo);
	}
	
	/**
	 * 修改 志愿者信息
	 * @param cdcVoluntaryInfo
	 */
	public void update(CdcVoluntaryInfo cdcVoluntaryInfo) {
		cdcVoluntaryInfoDao.update(cdcVoluntaryInfo);
	}
	
	/**
	 * 删除 志愿者信息
	 * @param voluntaryId
	 */
	public void delete(String voluntaryId) {
		cdcVoluntaryInfoDao.delete(voluntaryId);
	}
	
	/**
	 * 更新 志愿者信息参加活动次数
	 */
	public void updateCaperTimes(List<CdcVoluntaryInfo> cdcVoluntaryInfoList, int i) {
		cdcVoluntaryInfoDao.updateCaperTimes(cdcVoluntaryInfoList, i);
	}

	/**
	 * @Description: 根据活动编码获取志愿者信息
	 * @author xuexzh
	 */
	public DataSet queryByCaper(ParameterSet pset) {
		return cdcVoluntaryInfoDao.queryByCaper(pset);
	}
}