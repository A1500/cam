package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;
import com.inspur.cams.cdc.base.dao.ICdcTenementInfoDao;
import com.inspur.cams.cdc.base.data.CdcTenementInfo;

/**
 * @title:CdcTenementInfoDao
 * @description:
 * @author:
 * @since:2013-03-15
 * @version:1.0
*/
 public class CdcTenementInfoDao extends EntityDao<CdcTenementInfo> implements ICdcTenementInfoDao{

  	@Override
	public Class<CdcTenementInfo> getEntityClass() {
		return CdcTenementInfo.class;
	}
   
}
