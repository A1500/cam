package com.inspur.cams.dis.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.dis.base.dao.IDicDisMaterialTypeDao;
import com.inspur.cams.dis.base.data.DicDisMaterialType;

/**
 * 救灾发放物资类型(字典)dao
 * @author 
 * @date 2012-11-05
 */
public class DicDisMaterialTypeDao extends EntityDao<DicDisMaterialType> implements IDicDisMaterialTypeDao {
	
	@Override
	public Class<DicDisMaterialType> getEntityClass() {
		return DicDisMaterialType.class;
	}

}