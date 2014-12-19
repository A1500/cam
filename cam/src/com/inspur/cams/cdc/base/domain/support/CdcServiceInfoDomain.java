package com.inspur.cams.cdc.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcServiceInfoDao;
import com.inspur.cams.cdc.base.data.CdcServiceInfo;
import com.inspur.cams.cdc.base.domain.ICdcServiceInfoDomain;

/**
 * 基础信息社区服务信息�?Domain�???�类
 * @author 
 * @date [Tue Dec 20 07:56:23 GMT 2011]
 */
public class CdcServiceInfoDomain implements ICdcServiceInfoDomain {

	@Reference
	private ICdcServiceInfoDao cdcServiceInfoDao;

	/**
	 * ??��??基础信息社区服务信息�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcServiceInfoDao.query(pset);
	}

	/**
	 * �????基础信息社区服务信息�?
	 * @param cdcServiceInfo
	 */
	public void insert(CdcServiceInfo cdcServiceInfo) {
		cdcServiceInfoDao.insert(cdcServiceInfo);
	}
	
	/**
	 * �????基础信息社区服务信息�?
	 * @param cdcServiceInfo
	 */
	public void update(CdcServiceInfo cdcServiceInfo) {
		cdcServiceInfoDao.update(cdcServiceInfo);
	}
	
	/**
	 * ??????基础信息社区服务信息�?
	 * @param serviceId
	 */
	public void delete(String serviceId) {
		cdcServiceInfoDao.delete(serviceId);
	}

	public void delete(String recordId, String organCode) {
		cdcServiceInfoDao.delete(recordId,organCode);
	}

}