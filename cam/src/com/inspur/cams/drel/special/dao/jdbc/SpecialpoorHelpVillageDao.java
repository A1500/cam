package com.inspur.cams.drel.special.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.special.dao.ISpecialpoorHelpVillageDao;
import com.inspur.cams.drel.special.data.SpecialpoorHelpVillage;

/**
 * 帮包村信息表dao
 * @author 
 * @date 2013-08-12
 */
public class SpecialpoorHelpVillageDao extends EntityDao<SpecialpoorHelpVillage> implements ISpecialpoorHelpVillageDao {
	
	@Override
	public Class<SpecialpoorHelpVillage> getEntityClass() {
		return SpecialpoorHelpVillage.class;
	}

}