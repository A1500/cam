package com.inspur.sdmz.comm.analysis.spendOfDepartAnalysis.dao;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.util.domain.BaseJdbcDao;
@SuppressWarnings("unchecked")
public class SpendOfDepartAnalysisPieDao extends BaseJdbcDao {

	public DataSet getDataSet(ParameterSet pset) {
		
		StringBuffer sb = new StringBuffer();
		boolean whereFlag = false;
		sb.append("SELECT SAM_PLAN.PLAN_ORGAN_NAME MC, SUM(FUND) NUM");
		sb.append("  FROM SAM_PLAN ");
		String organId = (String) pset.getParameter("jzdwIdQuery");
		if(organId!=null&&!"".equals(organId)) {
			whereFlag = true;
			String[] organIds = organId.split(",");
			String tempId = "";
			for (int i = 0; i < organIds.length; i++) {
				if(!"".equals(organIds[i])) {
					if("".equals(tempId)) {
						tempId = ("'"+organIds[i]+"'");
					} else {
						tempId += (",'"+organIds[i]+"'");
					}
				}
			}
			sb.append(" WHERE SAM_PLAN.PLAN_ORGAN_ID IN ("+tempId+")");
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
		sb.append(" GROUP BY SAM_PLAN.PLAN_ORGAN_NAME, SAM_PLAN.PLAN_ORGAN_ID");
		sb.append(" ORDER BY SAM_PLAN.PLAN_ORGAN_ID");
		
		int start = pset.getPageStart();
		int limit = pset.getPageLimit();
		return this.executeDataset(sb.toString(),start,limit,true);
	}
	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
		
	}
}
