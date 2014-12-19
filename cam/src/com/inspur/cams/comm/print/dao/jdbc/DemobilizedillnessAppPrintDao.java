package com.inspur.cams.comm.print.dao.jdbc;

import java.sql.Types;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.print.dao.IPrintDao;

/**
 * 带病回乡申请表 查找数据用于 打印
 * @author Administrator
 *
 */
public class DemobilizedillnessAppPrintDao extends IPrintDao {

	@Override
	protected Class<BaseinfoPeople> getEntityClass() {

		return BaseinfoPeople.class;
	}
	
	@Override
	public DataSet queryData(ParameterSet pset) {
		ToDate todate = new ToDate();
		StringBuffer bf = new StringBuffer();
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT B.PHOTO_ID, C.FULL_NAME AS DOMICILE_NAME, B.POST_CODE, B.TEL_MOBILE,\n");
		sql.append("       B.NAME AS NAME,\n"); 
		sql.append("       (CASE B.SEX\n"); 
		sql.append("          WHEN '1' THEN\n"); 
		sql.append("           '男'\n"); 
		sql.append("          WHEN '2' THEN\n"); 
		sql.append("           '女'\n"); 
		sql.append("        END) AS SEX, B.ID_CARD, B.BIRTHDAY, B.TEL_MOBILE,\n"); 
		sql.append("       (CASE B.DOMICILE_TYPE\n"); 
		sql.append("          WHEN '1' THEN\n"); 
		sql.append("           '农村'\n"); 
		sql.append("          WHEN '2' THEN\n"); 
		sql.append("           '城镇'\n"); 
		sql.append("        END) AS DOMICILE_TYPE, D.CONSCRIPT_DATE, D.DECRUITMENT_DATE,\n"); 
		sql.append("       D.FORCES_NO, D.ASDP_NO, D.ILLESS_INFO,\n"); 
		sql.append(  todate.todate("t.TOWN_TRIAL_DATE")+" TOWN_TRIAL_DATE,");
		sql.append(  todate.todate("t.COUNTIES_REVIEW_DATE")+" COUNTIES_REVIEW_DATE,");
		sql.append(  todate.todate("t.CITIES_APPROVAL_DATE")+" CITIES_APPROVAL_DATE,");
		sql.append("      t.TOWN_VIEWS,t.TOWN_TRIAL_NAME,t.COUNTIES_VIEWS,t.COUNTIES_REVIEW_VIEW,t.CITIES_VIEWS,t.CITIES_APPROVAL_NAME, ");
		sql.append("       T.APPLY_DATE AS DT,\n"); 
		sql.append("       (CASE D.PHYSICLAL_STATUS\n"); 
		sql.append("          WHEN '1' THEN\n"); 
		sql.append("           '良好'\n"); 
		sql.append("          WHEN '2' THEN\n"); 
		sql.append("           '一般'\n"); 
		sql.append("          WHEN '3' THEN\n"); 
		sql.append("           '差'\n"); 
		sql.append("        END) AS PHYSICLAL_STATUS,\n"); 
		sql.append("       (CASE D.FAMILY_ECONOMICS\n"); 
		sql.append("          WHEN '1' THEN\n"); 
		sql.append("           '富裕'\n"); 
		sql.append("          WHEN '2' THEN\n"); 
		sql.append("           '一般'\n"); 
		sql.append("          WHEN '3' THEN\n"); 
		sql.append("           '困难'\n"); 
		sql.append("        END) AS FAMILY_ECONOMICS\n"); 
		sql.append("  FROM BPT_PEOPLE_DEMOBILIZED_ILLNESS D, BASEINFO_PEOPLE B,\n"); 
		sql.append("       BPT_APPLY_DEMOBILIZED T, BPT_PEOPLE P, DIC_CITY C\n"); 
		sql.append(" WHERE D.PEOPLE_ID = B.PEOPLE_ID AND B.PEOPLE_ID = T.PEOPLE_ID AND\n"); 
		sql.append("       T.PEOPLE_ID = P.PEOPLE_ID AND C.ID = B.DOMICILE_CODE AND\n"); 
		sql.append("       B.DEMOBILIZED_FLAG = ? AND P.DEMOBILIZED_TYEP_CODE = ? AND\n"); 
		sql.append("       T.SERVICE_TYPE = ? AND B.PEOPLE_ID = ? AND T.APPLY_ID = ?");

		String peopleId = (String)pset.getParameter("peopleId");
		String applyId = (String)pset.getParameter("applyId");
		
		DataSet ds = this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},new Object[]{1,42,45,peopleId,applyId}, true);
		return ds;
	}

}
