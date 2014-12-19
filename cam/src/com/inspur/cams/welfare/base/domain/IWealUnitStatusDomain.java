package com.inspur.cams.welfare.base.domain;

import org.loushang.next.data.*;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.welfare.base.data.*;

/**
 * @title:IWealUnitStatusDomain
 * @description:福利企业状态表domain
 * @author:liuxin
 * @since:2013-06-08
 * @version:1.0
 */
public interface IWealUnitStatusDomain {

	/**
	 * 查询
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加
	 * 
	 * @param wealUnitStatus
	 */
	@Trans
	public void insert(WealUnitStatus wealUnitStatus);

	/**
	 * 修改
	 * 
	 * @param wealUnitStatus
	 */
	@Trans
	public void update(WealUnitStatus wealUnitStatus);

	/**
	 * 删除
	 * 
	 * @param unitId
	 */
	@Trans
	public void delete(String unitId);

}