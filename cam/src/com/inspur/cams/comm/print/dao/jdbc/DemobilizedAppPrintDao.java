package com.inspur.cams.comm.print.dao.jdbc;

import java.sql.Types;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.print.dao.IPrintDao;

/**
 * @title:AssDisabilityAppPrintDao
 * @description:山东省领取定期抚恤金审批表打印
 * @author:
 * @since:2011-05-31
 * @version:1.0 
*/
 public class DemobilizedAppPrintDao extends IPrintDao{

	@Override 
	protected Class<BaseinfoPeople> getEntityClass() {
		return BaseinfoPeople.class;
	}

	/**
	 * 山东省在乡复员军人审批表
	 */
	public DataSet queryData(ParameterSet pst) {
		String peopleId = (String)pst.getParameter("peopleId");
		String applyId = (String)pst.getParameter("applyId");
		StringBuffer sql = new StringBuffer();
		ToDate todate = new ToDate();
		sql.append("SELECT T.PHOTO_ID, C.FULL_NAME AS DICNAME, T.NAME AS NAME,\n");
		sql.append("       (CASE T.SEX\n"); 
		sql.append("          WHEN '1' THEN\n"); 
		sql.append("           '男'\n"); 
		sql.append("          WHEN '2' THEN\n"); 
		sql.append("           '女'\n"); 
		sql.append("        END) AS SEX, T.ID_CARD AS IDCARD, T.BIRTHDAY AS BIRTHDAY,\n"); 
		sql.append(  todate.todate("g.TOWN_TRIAL_DATE")+" TOWN_TRIAL_DATE,");
		sql.append(  todate.todate("g.COUNTIES_REVIEW_DATE")+" COUNTIES_REVIEW_DATE,");
		sql.append(  todate.todate("g.CITIES_APPROVAL_DATE")+" CITIES_APPROVAL_DATE,");
		sql.append("        g.TOWN_VIEWS,g.TOWN_TRIAL_NAME,g.COUNTIES_VIEWS,g.COUNTIES_REVIEW_VIEW,g.CITIES_VIEWS,g.CITIES_APPROVAL_NAME, ");
		sql.append("       D.CONSCRIPT_DATE, D.DECRUITMENT_DATE,\n"); 
		sql.append("       (D.FORCES_NO || ' ' || D.POSITION) AS FORCES_NO_POSITION, D.ASDP_NO,\n"); 
		sql.append("       (CASE T.DOMICILE_TYPE\n"); 
		sql.append("          WHEN '1' THEN\n"); 
		sql.append("           '农村'\n"); 
		sql.append("          WHEN '2' THEN\n"); 
		sql.append("           '城镇'\n"); 
		sql.append("        END) AS DOMICILE_NAME\n"); 
		sql.append("  FROM BASEINFO_PEOPLE T, BPT_PEOPLE P, BPT_PEOPLE_DEMOBILIZED D,\n"); 
		sql.append("       BPT_APPLY_DEMOBILIZED G, DIC_CITY C\n"); 
		sql.append(" WHERE T.PEOPLE_ID = P.PEOPLE_ID AND P.PEOPLE_ID = D.PEOPLE_ID AND\n"); 
		sql.append("       D.PEOPLE_ID = G.PEOPLE_ID AND T.DOMICILE_CODE = C.ID AND\n"); 
		sql.append("       T.DEMOBILIZED_FLAG = ? AND T.PERSONAL_STATS_TAG != ? AND\n"); 
		sql.append("       P.DEMOBILIZED_TYEP_CODE = ? AND T.PEOPLE_ID = ? AND G.APPLY_ID = ?");

		DataSet ds = this.executeDataset(sql.toString(), new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR}, new Object[]{1,4,41,peopleId,applyId}, true);
		return ds;
	}
	
   
}
