package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcNatureInfoDao;
import com.inspur.cams.cdc.base.data.CdcNatureInfo;

/**
 * 基础信息自然状况信息�?Dao�???�类
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public class CdcNatureInfoDao extends EntityDao<CdcNatureInfo> implements ICdcNatureInfoDao {
	
	@Override
	public Class<CdcNatureInfo> getEntityClass() {
		return CdcNatureInfo.class;
	}

}