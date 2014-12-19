package com.inspur.cams.comm.print.dao.jdbc;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.print.dao.IPrintDao;
/**
 * 参试申请表 查找数据用于 打印
 * @author Administrator
 *
 */
public class TestAppPrintDao extends IPrintDao {

	

	@Override
	protected Class<BaseinfoPeople> getEntityClass() {
		return BaseinfoPeople.class;
	}
	
	public DataSet queryData(ParameterSet pset) {
		ToDate toDate = new ToDate();
		int type[]=new int[4];
		Object obj[] = new Object[4];
		StringBuffer sql = new StringBuffer();
		String organCode = (String)pset.getParameter("organCode");
		String organName = (String)pset.getParameter("organName");
		sql.append("SELECT B.PHOTO_ID, B.NAME AS NAME,\n");
		sql.append("       (CASE B.SEX\n"); 
		sql.append("          WHEN '1' THEN '男'\n"); 
		sql.append("          WHEN '2' THEN '女'\n"); 
		sql.append("        END) AS SEX, N.NAME AS NATION_NAME, B.BIRTHDAY, B.ID_CARD,\n"); 
		sql.append("       (CASE B.DOMICILE_TYPE\n"); 
		sql.append("          WHEN '1' THEN '农村'\n"); 
		sql.append("          WHEN '2' THEN '城镇'\n"); 
		sql.append("        END) AS DOMICILE_TYPE,\n"); 
		sql.append("       DC.FULL_NAME || B.DOMICILE_ADDRESS AS DOMICILE_ADDRESS,\n"); 
		sql.append("       C.FULL_NAME || B.ADDRESS AS ADDRESS, W.CONSCRIPTC_DATE,\n"); 
		sql.append("       W.DECRUITMENT_DATE,\n"); 
		sql.append("       (CASE W.HEALTH_STATE_CODE\n"); 
		sql.append("          WHEN '10' THEN '健康或良好'\n"); 
		sql.append("          WHEN '20' THEN '一般或较弱'\n"); 
		sql.append("          WHEN '30' THEN '有慢性病'\n"); 
		sql.append("          WHEN '60' THEN '残疾'\n"); 
		sql.append("        END) AS HEALTH_STATE,\n"); 
		sql.append("       (CASE W.LIFE_STATE_CODE\n"); 
		sql.append("          WHEN '1' THEN '良好'\n"); 
		sql.append("          WHEN '2' THEN '一般'\n"); 
		sql.append("          WHEN '3' THEN '差'\n"); 
		sql.append("        END) AS LIFE_STATE, W.ASDP_NO, W.FORCES_NO, W.POSITION,\n"); 
		sql.append("       (CASE W.TESTED_TYPE\n"); 
		sql.append("          WHEN '1' THEN '原8023部队退役人员'\n"); 
		sql.append("          WHEN '2' THEN '其他参加核试验军队退役人员'\n"); 
		sql.append("        END) AS TESTED_TYPE,\n"); 
		sql.append("       (CASE W.IS_HEALTH_FLAG\n"); 
		sql.append("          WHEN '1' THEN '是'\n"); 
		sql.append("          WHEN '2' THEN '否'\n"); 
		sql.append("        END) AS IS_HEALTH, W.ENJOY_MON,\n"); 
		sql.append("       (CASE W.DISABILITY_LEVEL_CODE\n"); 
		sql.append("          WHEN '01' THEN '一级'\n"); 
		sql.append("          WHEN '02' THEN '二级'\n"); 
		sql.append("          WHEN '03' THEN '三级'\n"); 
		sql.append("          WHEN '04' THEN '四级'\n"); 
		sql.append("          WHEN '05' THEN '五级'\n"); 
		sql.append("          WHEN '06' THEN '六级'\n"); 
		sql.append("          WHEN '07' THEN '七级'\n"); 
		sql.append("          WHEN '08' THEN '八级'\n"); 
		sql.append("          WHEN '09' THEN '九级'\n"); 
		sql.append("          WHEN '10' THEN '十级'\n"); 
		sql.append("        END) AS DISABILITY_LEVEL, W.DISABILITY_NUM, ? AS ORGANCODE,\n"); 
		sql.append("       ? AS ORGANNAME,IDENTITY_BASIS,\n"); 
		sql.append("       A.ACCEPT_ADVICE, A.ACCEPT_INCHARGE,"+toDate.todate("A.ACCEPT_DATE")+" AS ACCEPT_DATE, A.COUNTIES_ADUIT_ADVICE,\n"); 
		sql.append("       A.COUNTIES_ADUIT_INCHARGE,"+toDate.todate("A.COUNTIES_ADUIT_APPROVE_DATE")+" AS COUNTIES_ADUIT_APPROVE_DATE,\n"); 
		sql.append("       A.TOWN_ADUIT_ADVICE, A.TOWN_ADUIT_INCHARGE,\n"); 
		sql.append(" "+toDate.todate("A.TOWN_ADUIT_APPROVE_DATE")+" AS TOWN_ADUIT_APPROVE_DATE\n"); 
		sql.append("  FROM BASEINFO_PEOPLE B, DIC_CITY C, DIC_CITY DC, BPT_PEOPLE P,\n"); 
		sql.append("       BPT_PEOPLE_TESTED W, DIC_NATION N, BPT_APPLY_DEPENDANT A\n"); 
		sql.append(" WHERE A.PEOPLE_ID = B.PEOPLE_ID AND B.APANAGE_CODE = C.ID AND\n"); 
		sql.append("       B.DOMICILE_CODE = DC.ID AND B.PEOPLE_ID = P.PEOPLE_ID AND\n"); 
		sql.append("       P.PEOPLE_ID = W.PEOPLE_ID AND B.NATION = N.CODE AND B.WAR_FLAG = '1'");
		type[0]=12;
		type[1]=12;
		obj[0]=organCode;
		obj[1]=organName;
		String peopleId = (String)pset.getParameter("peopleId");
		String applyId = (String)pset.getParameter("applyId");
		if(peopleId != null && !"".equals(peopleId)) {
			sql.append(" and b.people_id = ?");
			type[2]=12;
			obj[2]=peopleId;
		}if(applyId != null && !"".equals(applyId)) {
			sql.append(" and a.apply_id = ?");
			type[3]=12;
			obj[3]=applyId;
		}
		DataSet ds = this.executeDataset(sql.toString(),type,obj, true);
		return ds;
	}

}
