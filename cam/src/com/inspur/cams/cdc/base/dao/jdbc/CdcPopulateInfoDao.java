package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcPopulateInfoDao;
import com.inspur.cams.cdc.base.data.CdcPopulateInfo;

/**
 * 基础信息人口状况信息表dao实现类
 * @author shgtch
 * @date 2011-12-30
 */
public class CdcPopulateInfoDao extends EntityDao<CdcPopulateInfo> implements ICdcPopulateInfoDao {
	
	@Override
	public Class<CdcPopulateInfo> getEntityClass() {
		return CdcPopulateInfo.class;
	}

}