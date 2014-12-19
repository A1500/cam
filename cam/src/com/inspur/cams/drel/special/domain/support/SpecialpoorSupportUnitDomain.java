package com.inspur.cams.drel.special.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.special.dao.ISpecialpoorSupportUnitDao;
import com.inspur.cams.drel.special.data.SpecialpoorSupportUnit;
import com.inspur.cams.drel.special.domain.ISpecialpoorSupportUnitDomain;

/**
 * 特殊困难帮扶单位信息表domain
 * @author 
 * @date 2013-08-12
 */
public class SpecialpoorSupportUnitDomain implements ISpecialpoorSupportUnitDomain {

	@Reference
	private ISpecialpoorSupportUnitDao specialpoorSupportUnitDao;

	/**
	 * 查询 特殊困难帮扶单位信息表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return specialpoorSupportUnitDao.query(pset);
	}

	/**
	 * 获取 特殊困难帮扶单位信息表
	 * @param pset
	 * @return
	 */
	public SpecialpoorSupportUnit get(String supportUnitCode) {
		return specialpoorSupportUnitDao.get(supportUnitCode);
	}

	/**
	 * 增加 特殊困难帮扶单位信息表
	 * @param specialpoorSupportUnit
	 */
	public void insert(SpecialpoorSupportUnit specialpoorSupportUnit) {
		specialpoorSupportUnitDao.insert(specialpoorSupportUnit);
	}
	
	/**
	 * 修改 特殊困难帮扶单位信息表
	 * @param specialpoorSupportUnit
	 */
	public void update(SpecialpoorSupportUnit specialpoorSupportUnit) {
		specialpoorSupportUnitDao.update(specialpoorSupportUnit);
	}
	
	/**
	 * 删除 特殊困难帮扶单位信息表
	 * @param supportUnitCode
	 */
	public void delete(String supportUnitCode) {
		specialpoorSupportUnitDao.delete(supportUnitCode);
	}

}