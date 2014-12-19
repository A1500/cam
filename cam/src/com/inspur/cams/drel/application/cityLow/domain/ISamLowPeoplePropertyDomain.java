package com.inspur.cams.drel.application.cityLow.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.application.cityLow.data.SamLowPeopleProperty;

/**
 * 低收入家庭成员财产表domain
 * @author 
 * @date 2014-03-11
 */
public interface ISamLowPeoplePropertyDomain {

	/**
	 * 查询 低收入家庭成员财产表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 低收入家庭成员财产表
	 * @param pset
	 * @return
	 */
	public SamLowPeopleProperty get(String propertyId);

	/**
	 * 增加 低收入家庭成员财产表
	 * @param samLowPeopleProperty
	 */
	@Trans
	public void insert(SamLowPeopleProperty samLowPeopleProperty);
	
	/**
	 * 修改 低收入家庭成员财产表
	 * @param samLowPeopleProperty
	 */
	@Trans
	public void update(SamLowPeopleProperty samLowPeopleProperty);
	
	/**
	 * 删除 低收入家庭成员财产表
	 * @param propertyId
	 */
	@Trans
	public void delete(String propertyId);

}