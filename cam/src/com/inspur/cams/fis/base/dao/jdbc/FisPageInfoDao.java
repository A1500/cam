package com.inspur.cams.fis.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.fis.base.dao.IFisPageInfoDao;
import com.inspur.cams.fis.base.data.FisPageInfo;

/**
 * 页面信息表dao
 * @author 
 * @date 2012-07-16
 */
public class FisPageInfoDao extends EntityDao<FisPageInfo> implements IFisPageInfoDao {
	
	@Override
	public Class<FisPageInfo> getEntityClass() {
		return FisPageInfo.class;
	}

}