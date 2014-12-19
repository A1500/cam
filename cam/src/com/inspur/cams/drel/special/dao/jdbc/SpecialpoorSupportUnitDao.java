package com.inspur.cams.drel.special.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.special.dao.ISpecialpoorSupportUnitDao;
import com.inspur.cams.drel.special.data.SpecialpoorSupportUnit;

/**
 * 特殊困难帮扶单位信息表dao
 * @author 
 * @date 2013-08-12
 */
public class SpecialpoorSupportUnitDao extends EntityDao<SpecialpoorSupportUnit> implements ISpecialpoorSupportUnitDao {
	
	@Override
	public Class<SpecialpoorSupportUnit> getEntityClass() {
		return SpecialpoorSupportUnit.class;
	}

}