package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcSuperviseReviewInfoDao;
import com.inspur.cams.cdc.base.data.CdcSuperviseReviewInfo;

/**
 * 基层民主民主监督信息�?Dao�???�类
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public class CdcSuperviseReviewInfoDao extends EntityDao<CdcSuperviseReviewInfo> implements ICdcSuperviseReviewInfoDao {
	
	@Override
	public Class<CdcSuperviseReviewInfo> getEntityClass() {
		return CdcSuperviseReviewInfo.class;
	}

}