package com.inspur.sdmz.comm.analysis.spendOfActivityAnalysis.dao;

import java.util.Iterator;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.util.domain.BaseJdbcDao;
@SuppressWarnings("unchecked")
public class SpendOfActivityDao extends BaseJdbcDao {

	public DataSet getDataSet(ParameterSet pset) {
		
		StringBuffer sb = new StringBuffer();
		boolean whereFlag = false;
		sb.append("SELECT SAM_PLAN.PLAN_NAME MC, SUM(FUND) NUM");
		sb.append("  FROM SAM_PLAN ");
		String jzfaId = (String) pset.getParameter("jzfaIdQuery");
		if(jzfaId!=null&&!"".equals(jzfaId)) {
			whereFlag = true;
			String[] jzfaIds = jzfaId.split(",");
			String tempId = "";
			for (int i = 0; i < jzfaIds.length; i++) {
				if(!"".equals(jzfaIds[i])) {
					if("".equals(tempId)) {
						tempId = ("'"+jzfaIds[i]+"'");
					} else {
						tempId += (",'"+jzfaIds[i]+"'");
					}
				}
			}
			sb.append(" WHERE SAM_PLAN.PLAN_ID IN ("+tempId+")");
		}
		String startDate = (String) pset.getParameter("startDateQuery");
		if(startDate!=null&&!"".equals(startDate)) {
			if(whereFlag) {
				sb.append(" AND ");
			} else {
				sb.append(" WHERE ");
				whereFlag = true;
			}
			sb.append(" SAM_PLAN.PLAN_BEGIN>='"+startDate+"' ");
		}
		String endDate = (String) pset.getParameter("endDateQuery");
		if(endDate!=null&&!"".equals(endDate)) {
			if(whereFlag) {
				sb.append(" AND ");
			} else {
				sb.append(" WHERE ");
				whereFlag = true;
			}
			sb.append(" SAM_PLAN.PLAN_BEGIN<='"+endDate+"' ");
		}
		sb.append(" GROUP BY SAM_PLAN.PLAN_NAME");
		sb.append(" ORDER BY SAM_PLAN.PLAN_NAME");
		
		int start = pset.getPageStart();
		int limit = pset.getPageLimit();
		return this.executeDataset(sb.toString(),start,limit,true);
	}
	private DataSet getApplyDataSet(DataSet ds) {
		if(ds==null||ds.getCount()<1) return new DataSet();
		Iterator<Record> it = ds.getRecordSet().iterator();
		String tempId = "";
		while(it.hasNext()) {
			Record record = it.next();
			String id = (String)record.get("id");
			if(tempId.indexOf(id)==-1) {
				tempId+=record.get("id");
			} else {
				
			}
		}
		return null;
	}
	
	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
		
	}
}
