package com.inspur.cams.fis.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.fis.base.dao.IFisCemeExpendInfoDao;
import com.inspur.cams.fis.base.data.FisCemeExpendInfo;

/**
 * 公墓扩建dao
 * @author 
 * @date 2013-09-29
 */
public class FisCemeExpendInfoDao extends EntityDao<FisCemeExpendInfo> implements IFisCemeExpendInfoDao {
	
	@Override
	public Class<FisCemeExpendInfo> getEntityClass() {
		return FisCemeExpendInfo.class;
	}

}