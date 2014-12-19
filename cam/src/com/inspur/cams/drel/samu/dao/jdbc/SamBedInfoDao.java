package com.inspur.cams.drel.samu.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.samu.dao.ISamBedInfoDao;
import com.inspur.cams.drel.samu.data.SamBedInfo;

/**
 * 床位信息dao
 * @author 
 * @date 2012-09-26
 */
public class SamBedInfoDao extends EntityDao<SamBedInfo> implements ISamBedInfoDao {
	
	@Override
	public Class<SamBedInfo> getEntityClass() {
		return SamBedInfo.class;
	}

}