package com.inspur.sdmz.comm.query.assistanceOfAreaQuery.dao;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.util.domain.BaseJdbcDao;

import com.inspur.sdmz.comm.util.BspUtil;

@SuppressWarnings("unchecked")
public class JzfaDao extends BaseJdbcDao implements IJzfaDao {

	public DataSet jzfaQuery(ParameterSet pset) {
		StringBuffer querySql = new StringBuffer("SELECT COUNT(*) NUM,SUM(FUND) FUND,SUM(FAMILY_NUM) FAMILY_NUM,sum(PEOPLE_NUM) PEOPLE_NUM,PLAN_ORGAN_ID,PLAN_ORGAN_NAME FROM SAM_PLAN WHERE 1=1 ");
		//JZRQ_Q >='20100907' AND JZRQ_Q <='20111111' GROUP BY JZDW_ID
		//当前登陆人单位区划
		String  organCode=BspUtil.getCorpOrgan().getOrganCode();
		     querySql.append("  AND PLAN_ORGAN_REGION   LIKE  '").append(organCode.subSequence(0, 6)).append("%'");
			 //jtxxSql.append(" and YGJZ_JTXX.LRDWQH LIKE '").append(createOrgan).append("%'");
		String startDate = (String) pset.getParameter("startDate");
		if(startDate!=null && !"".equals(startDate)) {
			querySql.append(" AND PLAN_BEGIN>='"+startDate+"'");
		}
		String endDate = (String) pset.getParameter("endDate");
		if(endDate!=null && !"".equals(endDate)) {
			querySql.append(" AND PLAN_BEGIN<='"+endDate+"'");
		}
		querySql.append(" GROUP BY PLAN_ORGAN_ID,PLAN_ORGAN_NAME ");
		
		return this.executeDataset(querySql.toString(),getDsStart(pset),getDsLimit(pset),true);
	}
	
	private int getDsStart(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageStart();
		}
		int start = 0;
		if("0".equals(excelType)) {  //导出当前页
			Integer startExcel = (java.lang.Integer) pset.getParameter("startExcel");
			if(startExcel!=null) {
				start = startExcel.intValue();
			}
		}
		return start;
	}
	private int getDsLimit(ParameterSet pset) {
		String excelType = (String)pset.getParameter("excelType");
		if(null==excelType||"0,1".indexOf(excelType)==-1) {
			return pset.getPageLimit();
		}
		int limit = ((java.lang.Integer) pset.getParameter("limitExcel")).intValue();
		return limit>1000?1000:limit;
	}
	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
		
	}
}
