package com.inspur.cams.drel.special.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.special.data.SpecialpoorSupportUnit;

/**
 * 特殊困难帮扶单位信息表domain
 * @author 
 * @date 2013-08-12
 */
public interface ISpecialpoorSupportUnitDomain {

	/**
	 * 查询 特殊困难帮扶单位信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 特殊困难帮扶单位信息表
	 * @param pset
	 * @return
	 */
	public SpecialpoorSupportUnit get(String supportUnitCode);

	/**
	 * 增加 特殊困难帮扶单位信息表
	 * @param specialpoorSupportUnit
	 */
	@Trans
	public void insert(SpecialpoorSupportUnit specialpoorSupportUnit);
	
	/**
	 * 修改 特殊困难帮扶单位信息表
	 * @param specialpoorSupportUnit
	 */
	@Trans
	public void update(SpecialpoorSupportUnit specialpoorSupportUnit);
	
	/**
	 * 删除 特殊困难帮扶单位信息表
	 * @param supportUnitCode
	 */
	@Trans
	public void delete(String supportUnitCode);

}