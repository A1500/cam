package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcNatureInfo;

/**
 * 基础信息自然状况信息�?Domain??��??
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public interface ICdcNatureInfoDomain {

	/**
	 * ??��??基础信息自然状况信息�?
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * �????基础信息自然状况信息�?
	 * @param cdcNatureInfo
	 */
	@Trans
	public void insert(CdcNatureInfo cdcNatureInfo);
	
	/**
	 * �????基础信息自然状况信息�?
	 * @param cdcNatureInfo
	 */
	@Trans
	public void update(CdcNatureInfo cdcNatureInfo);
	
	/**
	 * ??????基础信息自然状况信息�?
	 * @param natureId
	 */
	@Trans
	public void delete(String natureId);

}