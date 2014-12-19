package com.inspur.sdmz.comm.analysis.spendOfJzlxAnalysis.dao;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.util.domain.BaseJdbcDao;
@SuppressWarnings("unchecked")
public class SpendOfJzlxAnalysisPieDao extends BaseJdbcDao {

	public DataSet getDataSet(ParameterSet pset) {
		
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT DIC_ASSITANCE_TYPE_EXT.NAME MC, SUM(FUND) NUM");
		sb.append("  FROM SAM_PLAN,DIC_ASSITANCE_TYPE_EXT ");
		sb.append("   WHERE SAM_PLAN.PLAN_TYPE=DIC_ASSITANCE_TYPE_EXT.CODE ");
		String jzlx = (String) pset.getParameter("jzlxquery");
		if(jzlx!=null&&!"".equals(jzlx)) {
			//sb.append(" AND SAM_PLAN.PLAN_TYPE IN ('"+jzlx+"')");
			String[] szlxArr = jzlx.split(",");
			boolean andFlag = false;
			boolean orFlag = false;
			for (int i = 0; i < szlxArr.length; i++) {
				if(!"".equals(szlxArr[i])) {
					if(!andFlag) {
						sb.append(" AND (");
					}
					andFlag = true;
					if(!orFlag) {
						sb.append(" INSTR(SAM_PLAN.PLAN_TYPE,'"+szlxArr[i]+"',1)!=0");
						orFlag = true;
					} else {
						sb.append(" or INSTR(SAM_PLAN.PLAN_TYPE,'"+szlxArr[i]+"',1)!=0");
					}
				}
			}
			if(andFlag) {
				sb.append(")");
			}
		}
		String startDate = (String) pset.getParameter("startDateQuery");
		if(startDate!=null&&!"".equals(startDate)) {
			sb.append(" AND SAM_PLAN.PLAN_BEGIN>='"+startDate+"' ");
		}
		String endDate = (String) pset.getParameter("endDateQuery");
		if(endDate!=null&&!"".equals(endDate)) {
			sb.append(" AND SAM_PLAN.PLAN_BEGIN<='"+endDate+"' ");
		}
		sb.append(" GROUP BY DIC_ASSITANCE_TYPE_EXT.NAME");
		
		int start = pset.getPageStart();
		int limit = pset.getPageLimit();
		return this.executeDataset(sb.toString(),start,limit,true);
	}
	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
		
	}
}
