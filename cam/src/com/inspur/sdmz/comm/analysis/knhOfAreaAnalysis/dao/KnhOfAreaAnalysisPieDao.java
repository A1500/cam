package com.inspur.sdmz.comm.analysis.knhOfAreaAnalysis.dao;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.persistent.util.domain.BaseJdbcDao;
@SuppressWarnings("unchecked")
public class KnhOfAreaAnalysisPieDao extends BaseJdbcDao {

	public DataSet getDataSet(ParameterSet pset) {
		
		StringBuffer sb = new StringBuffer();
		sb.append("SELECT WE.NUM NUM,DIC_CITY.NAME MC FROM ");
		sb.append("(select BASEINFO_FAMILY.TOWN ADDRESS,COUNT(*) NUM");
		sb.append("  from BASEINFO_FAMILY, SAM_FAMILY_ASSISTANCE, DIC_ASSITANCE_TYPE_EXT ");
		sb.append(" where BASEINFO_FAMILY.FAMILY_ID = SAM_FAMILY_ASSISTANCE.FAMILY_ID(+)");
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
		sb.append(" GROUP BY BASEINFO_FAMILY.TOWN) WE,DIC_CITY ");
		sb.append(" WHERE WE.ADDRESS = DIC_CITY.ID");
		int start = pset.getPageStart();
		int limit = pset.getPageLimit();
		return this.executeDataset(sb.toString(),start,limit,true);
	}
	@Override
	protected void initDao() {
		// TODO Auto-generated method stub
		
	}
}
