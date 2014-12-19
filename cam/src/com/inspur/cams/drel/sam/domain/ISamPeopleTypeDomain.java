package com.inspur.cams.drel.sam.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.sam.data.SamPeopleType;

/**
 * @title:人员类型Domain接口
 * @description:
 * @author: zhangjian
 * @date:2012年5月28日
 * @version:1.0
 */
public interface ISamPeopleTypeDomain {
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
	 * @param samPeopleType
	 */
	@Trans
	public void insert(SamPeopleType samPeopleType);

	/**
	 * 更新
	 * 
	 * @param samPeopleType
	 */
	@Trans
	public void update(SamPeopleType samPeopleType);

	/**
	 * 根据人员id删除
	 * 
	 * @param peopleId
	 */
	@Trans
	public void deleteByPeopleId(String peopleId);
}
