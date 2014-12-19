package com.inspur.cams.jcm.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.jcm.dao.IDicOfficeEquipmentTypeDao;
import com.inspur.cams.jcm.data.DicOfficeEquipmentType;

/**
 * 办公设备类别dao
 * @author 
 * @date 2014-05-21
 */
public class DicOfficeEquipmentTypeDao extends EntityDao<DicOfficeEquipmentType> implements IDicOfficeEquipmentTypeDao {
	
	@Override
	public Class<DicOfficeEquipmentType> getEntityClass() {
		return DicOfficeEquipmentType.class;
	}

}