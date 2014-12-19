package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcFundInfoDao;
import com.inspur.cams.cdc.base.data.CdcFundInfo;

/**
 * 社区建设经费情况信息Dao实现类
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public class CdcFundInfoDao extends EntityDao<CdcFundInfo> implements ICdcFundInfoDao {
	
	@Override
	public Class<CdcFundInfo> getEntityClass() {
		return CdcFundInfo.class;
	}

}