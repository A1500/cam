package com.inspur.cams.cdc.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.cdc.base.data.CdcBaseinfoPeople;

/**
 * 人员基础信息domain
 * @author 
 * @date 2012-05-25
 */
public interface ICdcBaseinfoPeopleDomain {

	/**
	 * 查询 人员基础信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 人员基础信息
	 * @param pset
	 * @return
	 */
	public CdcBaseinfoPeople get(String peopleId);

	/**
	 * 增加 人员基础信息
	 * @param cdcBaseinfoPeople
	 */
	@Trans
	public void insert(CdcBaseinfoPeople cdcBaseinfoPeople);
	
	/**
	 * 修改 人员基础信息
	 * @param cdcBaseinfoPeople
	 */
	@Trans
	public void update(CdcBaseinfoPeople cdcBaseinfoPeople);
	
	/**
	 * 删除 人员基础信息
	 * @param peopleId
	 */
	@Trans
	public void delete(String peopleId);

	/**
	 * 删除家庭
	 * @param peopleId
	 */
	@Trans
	public void deleteFamily(String peopleId);

}