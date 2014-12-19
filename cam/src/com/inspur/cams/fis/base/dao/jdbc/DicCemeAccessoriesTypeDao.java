package com.inspur.cams.fis.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.fis.base.dao.IDicCemeAccessoriesTypeDao;
import com.inspur.cams.fis.base.data.DicCemeAccessoriesType;

/**
 * 公墓年检附件类型字典dao
 * @author 
 * @date 2013-08-01
 */
public class DicCemeAccessoriesTypeDao extends EntityDao<DicCemeAccessoriesType> implements IDicCemeAccessoriesTypeDao {
	
	@Override
	public Class<DicCemeAccessoriesType> getEntityClass() {
		return DicCemeAccessoriesType.class;
	}

}