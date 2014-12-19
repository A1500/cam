package com.inspur.cams.welfare.base.domain;

import org.loushang.next.data.*;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.welfare.base.data.*;

/**
 * @title:IWealUnitApplyDomain
 * @description:福利企业业务表domain
 * @author:liuxin
 * @since:2013-06-08
 * @version:1.0
 */
public interface IWealUnitApplyDomain {

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
	 * @param wealUnitApply
	 */
	@Trans
	public void insert(WealUnitApply wealUnitApply);

	/**
	 * 修改
	 * 
	 * @param wealUnitApply
	 */
	@Trans
	public void update(WealUnitApply wealUnitApply);

	/**
	 * 删除
	 * 
	 * @param taskCode
	 */
	@Trans
	public void delete(String taskCode);

	@Trans
	public DataSet queryQualificationList(ParameterSet pset);

	public DataSet queryQualificationPrintList(ParameterSet pset);

	@Trans
	public DataSet queryCheck(ParameterSet pset);

}