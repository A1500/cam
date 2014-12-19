package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcOrganInfoDao;
import com.inspur.cams.cdc.base.data.CdcOrganInfo;

/**
 * 基础信息社区单位组织信息dao接口
 * @author shgtch
 * @date 2012-1-4
 */
public class CdcOrganInfoDao extends EntityDao<CdcOrganInfo> implements ICdcOrganInfoDao {
	
	@Override
	public Class<CdcOrganInfo> getEntityClass() {
		return CdcOrganInfo.class;
	}

}