package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcServiceFacilities;

/**
 * 社区服务设施信息domain接口
 * @author 
 * @date 
 */
public interface ICdcServiceFacilitiesDomain {

	/**
	 * 社区服务设施信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加社区服务设施信息
	 * @param cdcConstructInfo
	 */
	@Trans
	public void insert(CdcServiceFacilities cdcServiceFacilities);
	
	/**
	 * 修改社区服务设施信息
	 * @param cdcConstructInfo
	 */
	@Trans
	public void update(CdcServiceFacilities cdcServiceFacilities);
	
	/**
	 * 删除社区服务设施信息
	 * @param constructId
	 */
	@Trans
	public void delete(String constructionId);
	/**
	 * 汇总社区服务设施信息
	 */
	@Trans
	public void sum(CdcServiceFacilities cdcServiceFacilities);
	/**
	 * 查询社区服务设施
	 */
	public DataSet queryList(ParameterSet pset);
	
	/**
	 * 上报社区服务设施
	 */
	public void report(String id);
}