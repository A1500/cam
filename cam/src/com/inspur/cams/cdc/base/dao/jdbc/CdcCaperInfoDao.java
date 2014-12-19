package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcCaperInfoDao;
import com.inspur.cams.cdc.base.data.CdcCaperInfo;

/**
 * 活动信息dao
 * @author 
 * @date 2013-02-26
 */
public class CdcCaperInfoDao extends EntityDao<CdcCaperInfo> implements ICdcCaperInfoDao {
	
	@Override
	public Class<CdcCaperInfo> getEntityClass() {
		return CdcCaperInfo.class;
	}

}