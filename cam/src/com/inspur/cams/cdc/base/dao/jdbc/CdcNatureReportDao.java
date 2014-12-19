package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcNatureReportDao;
import com.inspur.cams.cdc.base.data.CdcNatureReport;

/**
 * 基础信息自然状况统计�?Dao�???�类
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public class CdcNatureReportDao extends EntityDao<CdcNatureReport> implements ICdcNatureReportDao {
	
	@Override
	public Class<CdcNatureReport> getEntityClass() {
		return CdcNatureReport.class;
	}

}