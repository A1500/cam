package com.inspur.cams.comm.print.dao.jdbc;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.print.dao.IPrintDao;
/**
 * 参战申请表 查找数据用于 打印
 * @author Administrator
 *
 */
public class WarAppPrintDao extends  IPrintDao {

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
		sql.append("       C.FULL_NAME || B.ADDRESS AS ADDRESS,\n"); 
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
		sql.append("        END) AS LIFE_STATE, W.ASDP_NO, W.CONSCRIPTC_DATE, W.DECRUITMENT_DATE,\n"); 
		sql.append("       W.FORCES_NO, W.POSITION,\n"); 
		sql.append("       (CASE W.WAR_TYPE_CODE\n"); 
		sql.append("          WHEN '01' THEN '解放一江山岛'\n"); 
		sql.append("          WHEN '02' THEN '川、甘、青滇藏地区平叛作战'\n"); 
		sql.append("          WHEN '03' THEN '炮击金门作战'\n"); 
		sql.append("          WHEN '04' THEN '中缅边境勘界警卫作战'\n"); 
		sql.append("          WHEN '05' THEN '中印边境自卫反击战'\n"); 
		sql.append("          WHEN '06' THEN '八六海战'\n"); 
		sql.append("          WHEN '07' THEN '崇武以东海战'\n"); 
		sql.append("          WHEN '08' THEN '援越抗美作战'\n"); 
		sql.append("          WHEN '09' THEN '援老抗美作战'\n"); 
		sql.append("          WHEN '10' THEN '珍宝岛自卫反击作战'\n"); 
		sql.append("          WHEN '11' THEN '西沙群岛自卫反击作战'\n"); 
		sql.append("          WHEN '12' THEN '中越边境自卫还击作战'\n"); 
		sql.append("          WHEN '13' THEN '老山、者阴山地区对越防御作战'\n"); 
		sql.append("          WHEN '14' THEN '南沙群岛自卫反击作战'\n"); 
		sql.append("          WHEN '15' THEN '需经军委、总部认定的其他作战行动'\n"); 
		sql.append("          WHEN '16' THEN '其他'\n"); 
		sql.append("        END) AS WAR_TYPE, W.ENJOY_MON, ? AS ORGANCODE, ? AS ORGANNAME,\n"); 
		sql.append("       BA.ACCEPT_ADVICE, BA.ACCEPT_INCHARGE,"+toDate.todate("BA.ACCEPT_DATE")+" AS ACCEPT_DATE, BA.COUNTIES_ADUIT_ADVICE,\n"); 
		sql.append("       BA.COUNTIES_ADUIT_INCHARGE,"+toDate.todate("BA.COUNTIES_ADUIT_APPROVE_DATE")+" AS COUNTIES_ADUIT_APPROVE_DATE,\n"); 
		sql.append("       BA.TOWN_ADUIT_ADVICE, BA.TOWN_ADUIT_INCHARGE,\n"); 
		sql.append(" "+toDate.todate("BA.TOWN_ADUIT_APPROVE_DATE")+" AS TOWN_ADUIT_APPROVE_DATE\n"); 
		sql.append("  FROM BASEINFO_PEOPLE B, DIC_CITY C, DIC_CITY DC, BPT_PEOPLE P,\n"); 
		sql.append("       BPT_PEOPLE_WAR W, DIC_NATION N, BPT_APPLY_DEPENDANT BA\n"); 
		sql.append(" WHERE BA.PEOPLE_ID = B.PEOPLE_ID AND B.APANAGE_CODE = C.ID AND\n"); 
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
		}
		if(applyId != null && !"".equals(applyId)) {
			sql.append(" and BA.apply_id = ?");
			type[3]=12;
			obj[3]=applyId;
		}
		DataSet ds = this.executeDataset(sql.toString(), type, obj, true);
		return ds;
	}
}
