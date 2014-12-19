package com.inspur.cams.welfare.base.domain;

import org.loushang.next.data.*;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.welfare.base.data.*;

/**
 * @title:IWealUnitInfoDomain
 * @description:福利企业业务信息表domain
 * @author:liuxin
 * @since:2013-06-08
 * @version:1.0
 */
public interface IWealUnitInfoDomain {

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
	 * @param wealUnitInfo
	 */
	@Trans
	public void insert(WealUnitInfo wealUnitInfo);

	/**
	 * 修改
	 * 
	 * @param wealUnitInfo
	 */
	@Trans
	public void update(WealUnitInfo wealUnitInfo);

	/**
	 * 删除
	 * 
	 * @param taskCode
	 */
	@Trans
	public void delete(String taskCode);

}