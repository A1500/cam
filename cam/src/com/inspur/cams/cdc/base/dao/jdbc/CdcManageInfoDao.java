package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcManageInfoDao;
import com.inspur.cams.cdc.base.data.CdcManageInfo;

/**
 * 基层民主民主管理信息�?Dao�???�类
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public class CdcManageInfoDao extends EntityDao<CdcManageInfo> implements ICdcManageInfoDao {
	
	@Override
	public Class<CdcManageInfo> getEntityClass() {
		return CdcManageInfo.class;
	}

}