package com.inspur.cams.cdc.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.util.domain.BaseJdbcDao;

import com.inspur.cams.cdc.base.dao.ICdcElectionSumDao;

/**
 * 民主选举汇总查询Dao
 * @author shgtch
 * @date 2011-12-31
 */
public class CdcElectionSumDao extends BaseJdbcDao implements ICdcElectionSumDao {

	public DataSet query(ParameterSet pset) {
		String tableName = (String) pset.getParameter("tableName");
		if (tableName == null || "".equals(tableName)) {
			throw new RuntimeException("汇总内容不能为空！");
		}
		String organCode = (String) pset.getParameter("organCode");
		if (organCode == null || "".equals(organCode)) {
			throw new RuntimeException("查询单位代码不能为空！");
		}
		String reportDate = (String) pset.getParameter("reportDate");
		if (reportDate == null || "".equals(reportDate)) {
			throw new RuntimeException("查询填报日期不能为空！");
		}
		StringBuffer sql = new StringBuffer();
		sql.append("select * from ");
		sql.append(tableName);
		sql.append(" where organ_code=? and report_date=?");
		return executeDataset(sql.toString(), new int[]{ Types.VARCHAR, Types.VARCHAR }, new Object[]{ organCode, reportDate }, true);
	}

	public DataSet queryByParentCode(ParameterSet pset) {
		String tableName = (String) pset.getParameter("tableName");
		if (tableName == null || "".equals(tableName)) {
			throw new RuntimeException("汇总内容不能为空！");
		}
		String parentCode = (String) pset.getParameter("parentCode");
		if (parentCode == null || "".equals(parentCode)) {
			throw new RuntimeException("查询上级单位代码不能为空！");
		}
		String reportDate = (String) pset.getParameter("reportDate");
		if (reportDate == null || "".equals(reportDate)) {
			throw new RuntimeException("查询填报日期不能为空！");
		}
		StringBuffer sql = new StringBuffer();
		sql.append("select * from ");
		sql.append(tableName);
		sql.append(" where parent_code=? and report_date=?");
		return executeDataset(sql.toString(), new int[]{ Types.VARCHAR, Types.VARCHAR }, new Object[]{ parentCode, reportDate }, true);
	}

	@Override
	protected void initDao() {
		
	}
	
}