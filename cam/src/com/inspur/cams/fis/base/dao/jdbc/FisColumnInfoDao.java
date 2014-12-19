package com.inspur.cams.fis.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.fis.base.dao.IFisColumnInfoDao;
import com.inspur.cams.fis.base.data.FisColumnInfo;

/**
 * 页面列描述dao
 * @author 
 * @date 2012-07-16
 */
public class FisColumnInfoDao extends EntityDao<FisColumnInfo> implements IFisColumnInfoDao {
	
	@Override
	public Class<FisColumnInfo> getEntityClass() {
		return FisColumnInfo.class;
	}

}