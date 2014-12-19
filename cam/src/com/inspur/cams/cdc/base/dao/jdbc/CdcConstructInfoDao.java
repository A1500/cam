package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcConstructInfoDao;
import com.inspur.cams.cdc.base.data.CdcConstructInfo;

/**
 * 基础信息农村社区规划信息表dao实现类
 * @author shgtch
 * @date 2012-2-7
 */
public class CdcConstructInfoDao extends EntityDao<CdcConstructInfo> implements ICdcConstructInfoDao {
	
	@Override
	public Class<CdcConstructInfo> getEntityClass() {
		return CdcConstructInfo.class;
	}

}