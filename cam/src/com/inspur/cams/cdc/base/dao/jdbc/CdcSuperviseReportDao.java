package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcSuperviseReportDao;
import com.inspur.cams.cdc.base.data.CdcSuperviseReport;

/**
 * 基层民主民主监督统计�?Dao�???�类
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public class CdcSuperviseReportDao extends EntityDao<CdcSuperviseReport> implements ICdcSuperviseReportDao {
	
	@Override
	public Class<CdcSuperviseReport> getEntityClass() {
		return CdcSuperviseReport.class;
	}

}