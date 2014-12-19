package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcDecisionReportDao;
import com.inspur.cams.cdc.base.data.CdcDecisionReport;

/**
 * 基层民主民主决策信息表Dao实现类
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcDecisionReportDao extends EntityDao<CdcDecisionReport> implements ICdcDecisionReportDao {
	
	@Override
	public Class<CdcDecisionReport> getEntityClass() {
		return CdcDecisionReport.class;
	}

}