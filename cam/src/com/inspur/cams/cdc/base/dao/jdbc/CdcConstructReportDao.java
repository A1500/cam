package com.inspur.cams.cdc.base.dao.jdbc;

import org.loushang.next.dao.EntityDao;

import com.inspur.cams.cdc.base.dao.ICdcConstructReportDao;
import com.inspur.cams.cdc.base.data.CdcConstructReport;

/**
 * 基础信息农村社区规划统计表dao实现类
 * @author shgtch
 * @date 2012-2-7
 */
public class CdcConstructReportDao extends EntityDao<CdcConstructReport> implements ICdcConstructReportDao {
	
	@Override
	public Class<CdcConstructReport> getEntityClass() {
		return CdcConstructReport.class;
	}

}