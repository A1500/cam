package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcManageReportDao;
import com.inspur.cams.cdc.base.data.CdcManageReport;

/**
 * 基层民主民主管理统计�?Dao�???�类
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public class CdcManageReportDao extends EntityDao<CdcManageReport> implements ICdcManageReportDao {
	
	@Override
	public Class<CdcManageReport> getEntityClass() {
		return CdcManageReport.class;
	}

}