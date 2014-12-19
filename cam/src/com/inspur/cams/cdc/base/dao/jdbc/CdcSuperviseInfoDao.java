package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcSuperviseInfoDao;
import com.inspur.cams.cdc.base.data.CdcSuperviseInfo;

/**
 * 基层民主民主监督信息�?Dao�???�类
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public class CdcSuperviseInfoDao extends EntityDao<CdcSuperviseInfo> implements ICdcSuperviseInfoDao {
	
	@Override
	public Class<CdcSuperviseInfo> getEntityClass() {
		return CdcSuperviseInfo.class;
	}

}