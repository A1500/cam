package com.inspur.sdmz.comm.analysis.knhGrowthAnalysis.dao;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.util.domain.BaseJdbcDao;
@SuppressWarnings("unchecked")
public class KnhGrowthAnalysisLineDao extends BaseJdbcDao {

	public DataSet getDataSet(ParameterSet pset) {
		
		StringBuffer sb = new StringBuffer();
		String date = (String) pset.getParameter("date");
		String dateElement1 = "";
		String dateElement2 = "";
		if("YEAR".equals(date)) {
			dateElement1 = "SUBSTR(BASEINFO_FAMILY.REG_TIME,0,4)";
			dateElement2 = "||'年' AS MC";
		} else {
			dateElement1 = "SUBSTR(BASEINFO_FAMILY.REG_TIME,0,6)";
			dateElement2 = "||'月' AS MC";
		}
		sb.append("SELECT "+dateElement1+dateElement2+",COUNT(*) NUM FROM BASEINFO_FAMILY WHERE BASEINFO_FAMILY.FAMILY_ID IN (");
		sb.append("		SELECT SAM_FAMILY_ASSISTANCE.FAMILY_ID FROM SAM_FAMILY_ASSISTANCE where 1=1 ");
		String jzlx = (String) pset.getParameter("jzlxQuery");
		if(jzlx!=null && !"".equals(jzlx)) {
			//sb.append("  WHERE SAM_FAMILY_ASSISTANCE.ASSISTANCE_TYPE IN('"+jzlx+"')");
			String[] szlxArr = jzlx.split(",");
			boolean andFlag = false;
			boolean orFlag = false;
			for (int i = 0; i < szlxArr.length; i++) {
				if(!"".equals(szlxArr[i])) {
					if(!andFlag) {
						sb.append(" and (");
					}
					andFlag = true;
					if(!orFlag) {
						sb.append(" INSTR(SAM_FAMILY_ASSISTANCE.ASSISTANCE_TYPE,'"+szlxArr[i]+"',1)!=0");
						orFlag = true;
					} else {
						sb.append(" or INSTR(SAM_FAMILY_ASSISTANCE.ASSISTANCE_TYPE,'"+szlxArr[i]+"',1)!=0");
					}
				}
			}
			if(andFlag) {
				sb.append(")");
			}
		}
		sb.append(" )");
		sb.append(" AND BASEINFO_FAMILY.REG_TIME IS NOT NULL ");
		String county = (String) pset.getParameter("countyquery");
		if(county!=null && !"".equals(county)) {
			sb.append(" AND BASEINFO_FAMILY.COUNTY='"+county+"'");
		}
		String dz_zhen = (String) pset.getParameter("dzZhenquery");
		if(dz_zhen!=null && !"".equals(dz_zhen)) {
			sb.append(" AND BASEINFO_FAMILY.TOWN='"+dz_zhen+"'");
		}
		String dz_cun = (String) pset.getParameter("dzCunquery");
		if(dz_cun!=null && !"".equals(dz_cun)) {
			sb.append(" AND BASEINFO_FAMILY.VILLAGE='"+dz_cun+"'");
		}
		String startDate = (String) pset.getParameter("startDateQuery");
		if(startDate!=null&&!"".equals(startDate)) {
			sb.append(" AND BASEINFO_FAMILY.REG_TIME>='"+startDate+"' ");
		}
		String endDate = (String) pset.getParameter("endDateQuery");
		if(endDate!=null&&!"".equals(endDate)) {
			sb.append(" AND BASEINFO_FAMILY.REG_TIME<='"+endDate+"' ");
		}
		sb.append("		GROUP BY "+dateElement1);
		sb.append("		ORDER BY "+dateElement1);
		
		int start = pset.getPageStart();
		int limit = pset.getPageLimit();
		return this.executeDataset(sb.toString(),start,limit,true);
	}
	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
		
	}
}
