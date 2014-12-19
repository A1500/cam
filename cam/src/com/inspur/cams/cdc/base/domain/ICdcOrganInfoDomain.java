package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcOrganInfo;

/**
 * 基础信息社区单位组织信息表domain接口
 * @author shgtch
 * @date 2011-12-31
 */
public interface ICdcOrganInfoDomain {

	/**
	 * 查询基础信息社区单位组织信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加基础信息社区单位组织信息
	 * @param cdcOrganInfo
	 */
	@Trans
	public void insert(CdcOrganInfo cdcOrganInfo);
	
	/**
	 * 修改基础信息社区单位组织信息
	 * @param cdcOrganInfo
	 */
	@Trans
	public void update(CdcOrganInfo cdcOrganInfo);
	
	/**
	 * 删除基础信息社区单位组织信息
	 * @param organId
	 */
	@Trans
	public void delete(String organId);

}