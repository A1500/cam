package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcServiceInfo;

/**
 * 基础信息社区服务信息�?Domain??��??
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public interface ICdcServiceInfoDomain {

	/**
	 * ??��??基础信息社区服务信息�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * �????基础信息社区服务信息�?
	 * @param cdcServiceInfo
	 */
	@Trans
	public void insert(CdcServiceInfo cdcServiceInfo);
	
	/**
	 * �????基础信息社区服务信息�?
	 * @param cdcServiceInfo
	 */
	@Trans
	public void update(CdcServiceInfo cdcServiceInfo);
	
	/**
	 * ??????基础信息社区服务信息�?
	 * @param serviceId
	 */
	@Trans
	public void delete(String serviceId);

	/**
	 * 删除某单位某次填报内容
	 * @param recordId
	 * @param organCode
	 */
	@Trans
	public void delete(String recordId, String organCode);

}