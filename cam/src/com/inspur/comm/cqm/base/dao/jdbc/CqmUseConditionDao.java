package com.inspur.comm.cqm.base.dao.jdbc;

import java.sql.Types;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.comm.cqm.base.dao.ICqmUseConditionDao;
import com.inspur.comm.cqm.base.data.CqmUseCondition;

public class CqmUseConditionDao extends EntityDao<CqmUseCondition> implements ICqmUseConditionDao {

	@Override
	protected Class<CqmUseCondition> getEntityClass() {
		return CqmUseCondition.class;
	}

	public void deleteByReportIdViewId(String reportId,String viewId) {
		this.executeUpdate("DELETE FROM CQM_USE_CONDITION WHERE REPORT_ID = ? AND　VIEW_ID = ?  ",
				new int[]{Types.VARCHAR,Types.VARCHAR},new Object[]{reportId,viewId});
	}

	public DataSet queryUserCondition(ParameterSet pset) {
		// TODO Auto-generated method stub
		return null;
	}

	public void deleteByReportId(String reportId) {
		this.executeUpdate("DELETE FROM CQM_USE_CONDITION WHERE REPORT_ID = ? ",
				new int[]{Types.VARCHAR},new Object[]{reportId});
	}


}
