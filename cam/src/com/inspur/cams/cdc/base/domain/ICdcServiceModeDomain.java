package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcServiceMode;

/**
 * 基础信息社区服务方式信息�?Domain??��??
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public interface ICdcServiceModeDomain {

	/**
	 * ??��??基础信息社区服务方式信息�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * �????基础信息社区服务方式信息�?
	 * @param cdcServiceMode
	 */
	@Trans
	public void insert(CdcServiceMode cdcServiceMode);
	
	/**
	 * �????基础信息社区服务方式信息�?
	 * @param cdcServiceMode
	 */
	@Trans
	public void update(CdcServiceMode cdcServiceMode);
	
	/**
	 * ??????基础信息社区服务方式信息�?
	 * @param modeId
	 */
	@Trans
	public void delete(String modeId);

	public DataSet queryList(ParameterSet pset);

	@Trans
	public void report(String id);

	@Trans
	public void audit(String id);

	@Trans
	public void sum(CdcServiceMode cdcServiceMode);

}