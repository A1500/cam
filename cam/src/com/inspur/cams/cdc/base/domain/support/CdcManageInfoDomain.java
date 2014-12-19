package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcManageInfoDao;
import com.inspur.cams.cdc.base.data.CdcManageInfo;
import com.inspur.cams.cdc.base.domain.ICdcManageInfoDomain;

/**
 * 基层民主民主管理信息�?Domain�???�类
 * @author 
 * @date [Tue Dec 20 07:56:23 GMT 2011]
 */
public class CdcManageInfoDomain implements ICdcManageInfoDomain {

	@Reference
	private ICdcManageInfoDao cdcManageInfoDao;

	/**
	 * ??��??基层民主民主管理信息�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcManageInfoDao.query(pset);
	}

	/**
	 * �????基层民主民主管理信息�?
	 * @param cdcManageInfo
	 */
	public void insert(CdcManageInfo cdcManageInfo) {
		cdcManageInfoDao.insert(cdcManageInfo);
	}
	
	/**
	 * �????基层民主民主管理信息�?
	 * @param cdcManageInfo
	 */
	public void update(CdcManageInfo cdcManageInfo) {
		cdcManageInfoDao.update(cdcManageInfo);
	}
	
	/**
	 * ??????基层民主民主管理信息�?
	 * @param manageId
	 */
	public void delete(String manageId) {
		cdcManageInfoDao.delete(manageId);
	}

}