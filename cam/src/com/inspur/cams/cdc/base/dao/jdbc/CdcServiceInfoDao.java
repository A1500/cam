package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcServiceInfoDao;
import com.inspur.cams.cdc.base.data.CdcServiceInfo;

/**
 * 基础信息社区服务信息�?Dao�???�类
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public class CdcServiceInfoDao extends EntityDao<CdcServiceInfo> implements ICdcServiceInfoDao {
	
	@Override
	public Class<CdcServiceInfo> getEntityClass() {
		return CdcServiceInfo.class;
	}

	public void delete(String recordId, String organCode) {
		String sql = "DELETE FROM CDC_SERVICE_INFO T WHERE T.RECORD_ID = ? ";
		this.executeUpdate(sql,new int[]{Types.VARCHAR},new Object[]{recordId});
	}

}