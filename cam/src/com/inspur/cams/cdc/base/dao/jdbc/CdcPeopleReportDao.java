package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcPeopleReportDao;
import com.inspur.cams.cdc.base.data.CdcPeopleReport;

/**
 * 基础信息两委成员与工作�?�统计表Dao�???�类
 * @author 
 * @date [Mon Dec 19 11:31:22 GMT 2011]
 */
public class CdcPeopleReportDao extends EntityDao<CdcPeopleReport> implements ICdcPeopleReportDao {
	
	@Override
	public Class<CdcPeopleReport> getEntityClass() {
		return CdcPeopleReport.class;
	}

}