package com.inspur.cams.drel.samu.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.samu.dao.ISamGeroAccessoriesDao;
import com.inspur.cams.drel.samu.data.SamGeroAccessories;

/**
 * 敬老院附件信息表dao
 * @author 
 * @date 2012-10-24
 */
public class SamGeroAccessoriesDao extends EntityDao<SamGeroAccessories> implements ISamGeroAccessoriesDao {
	
	@Override
	public Class<SamGeroAccessories> getEntityClass() {
		return SamGeroAccessories.class;
	}

}