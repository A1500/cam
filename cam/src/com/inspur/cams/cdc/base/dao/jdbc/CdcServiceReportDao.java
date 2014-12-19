package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcServiceReportDao;
import com.inspur.cams.cdc.base.data.CdcServiceReport;

/**
 * 基础信息社区服务统计�?Dao�???�类
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public class CdcServiceReportDao extends EntityDao<CdcServiceReport> implements ICdcServiceReportDao {
	
	@Override
	public Class<CdcServiceReport> getEntityClass() {
		return CdcServiceReport.class;
	}

}