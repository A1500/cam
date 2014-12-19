package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomOrganCode;

/**
 * 组织机构代码备案domain接口
 * 
 * @author zhangjian
 * @date 2011-12-12
 */
public interface ISomOrganCodeDomain {

	/**
	 * 查询社会组织组织机构代码
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加社会组织组织机构代码
	 * 
	 * @param somOrganCode
	 */
	@Trans
	public void insert(SomOrganCode somOrganCode);

	/**
	 * 更新社会组织组织机构代码
	 * 
	 * @param somOrganCode
	 */
	@Trans
	public void update(SomOrganCode somOrganCode);
	
	@Trans
	public void del(String taskCode);
}
