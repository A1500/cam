package com.inspur.cams.drel.samu.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.drel.samu.dao.ISamRoomInfoDao;
import com.inspur.cams.drel.samu.data.SamRoomInfo;

/**
 * 房间信息dao
 * @author 
 * @date 2012-09-26
 */
public class SamRoomInfoDao extends EntityDao<SamRoomInfo> implements ISamRoomInfoDao {
	
	@Override
	public Class<SamRoomInfo> getEntityClass() {
		return SamRoomInfo.class;
	}

}