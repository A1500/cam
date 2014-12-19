package com.inspur.sdmz.comm.analysis.knhBySexAnalysis.dao;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.util.domain.BaseJdbcDao;
@SuppressWarnings("unchecked")
public class KnhBySexAnalysisPieDao extends BaseJdbcDao {

	public DataSet getDataSet(ParameterSet pset) {
		
		StringBuffer sb = new StringBuffer();
		sb.append("select count(*) NUM, BASEINFO_PEOPLE.SEX MC");
		sb.append("  from (select BASEINFO_FAMILY.FAMILY_ID FAMILY_ID");
		sb.append("          from SAM_FAMILY_ASSISTANCE, BASEINFO_FAMILY");
		sb.append("         where BASEINFO_FAMILY.FAMILY_ID = SAM_FAMILY_ASSISTANCE.FAMILY_ID(+)");
		String jzlx = (String) pset.getParameter("jzlxQuery");
		if(jzlx!=null && !"".equals(jzlx)) {
			//sb.append("  AND SAM_FAMILY_ASSISTANCE.ASSISTANCE_TYPE IN('"+jzlx+"')");
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
		sb.append(" GROUP BY BASEINFO_FAMILY.FAMILY_ID) S,");
		sb.append("       BASEINFO_PEOPLE");
		sb.append(" where S.FAMILY_ID = BASEINFO_PEOPLE.FAMILY_ID");
		sb.append(" group by BASEINFO_PEOPLE.SEX");

		int start = pset.getPageStart();
		int limit = pset.getPageLimit();
		return this.executeDataset(sb.toString(),start,limit,true);
	}
	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
		
	}
}
