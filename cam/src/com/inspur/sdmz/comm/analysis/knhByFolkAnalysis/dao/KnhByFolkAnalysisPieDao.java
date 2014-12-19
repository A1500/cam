package com.inspur.sdmz.comm.analysis.knhByFolkAnalysis.dao;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.util.domain.BaseJdbcDao;
@SuppressWarnings("unchecked")
public class KnhByFolkAnalysisPieDao extends BaseJdbcDao {

	public DataSet getDataSet(ParameterSet pset) {
		
		StringBuffer sb = new StringBuffer();
		sb.append("select  DIC_NATION.NAME MC,count(*) NUM ");
		sb.append("  from BASEINFO_PEOPLE,DIC_NATION ");
		sb.append("  where BASEINFO_PEOPLE.FAMILY_ID IN(");
		sb.append("  select BASEINFO_FAMILY.FAMILY_ID FAMILY_ID from SAM_FAMILY_ASSISTANCE, BASEINFO_FAMILY");
		sb.append("  where BASEINFO_FAMILY.FAMILY_ID = SAM_FAMILY_ASSISTANCE.FAMILY_ID(+)");
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
		sb.append(" )");
		sb.append(" AND DIC_NATION.CODE = BASEINFO_PEOPLE.NATION");
		String folk = (String) pset.getParameter("folkQuery");
		if(folk!=null && !"".equals(folk)) {
			sb.append("  AND BASEINFO_PEOPLE.NATION IN("+folk+")");
		}
		sb.append(" group by DIC_NATION.NAME,DIC_NATION.CODE");
		sb.append(" ORDER BY DIC_NATION.CODE");

		int start = pset.getPageStart();
		int limit = pset.getPageLimit();
		return this.executeDataset(sb.toString(),start,limit,true);
	}
	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
		
	}
}
