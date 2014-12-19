package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcEconomyInfoDao;
import com.inspur.cams.cdc.base.data.CdcEconomyInfo;

/**
 * 基础信息社区资产状况信息表dao实现类
 * @author shgtch
 * @date 2011-12-31
 */
public class CdcEconomyInfoDao extends EntityDao<CdcEconomyInfo> implements ICdcEconomyInfoDao {
	
	@Override
	public Class<CdcEconomyInfo> getEntityClass() {
		return CdcEconomyInfo.class;
	}

}