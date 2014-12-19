package com.inspur.cams.comm.print.dao.jdbc;

import java.sql.Types;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.print.dao.IPrintDao;
/**
 * 参战申请表 查找数据用于 打印
 * @author Administrator
 *
 */
public class OpenLetterPrintDao extends  IPrintDao {

	@Override
	protected Class<BaseinfoPeople> getEntityClass() {
		
		return BaseinfoPeople.class;
	}
	/**
	 * 公示书打印
	 * @param pset
	 * @return
	 */
	public DataSet queryData(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		String organId = (String)pset.getParameter("organId");
		organId = organId.substring(0, 6)+"000000";
		sql.append("SELECT T.NAME,\n");
		sql.append("       (CASE T.SEX\n"); 
		sql.append("          WHEN '1' THEN '男'\n"); 
		sql.append("          WHEN '2' THEN '女'\n"); 
		sql.append("        END) AS SEX, T.BIRTHDAY, C.FULL_NAME || T.ADDRESS AS ADDRESS,\n"); 
		sql.append("       T.WORK_UNIT_NAME, B.OPEN_DATE, B.OPENEND_DATE, B.OPENSTART_DATE,\n"); 
		sql.append("       B.ARMY_CONDITION, B.DECRUITMENT_DATE, B.CONSCRIPTC_DATE,\n"); 
		sql.append("       B.TO_ORGAN_ID, B.LAW, B.TREATMENT, B.OPEN_DAYS, B.ILL_DATE,\n"); 
		sql.append("       B.ILL_ADDRESS, B.ILL_BODY_CHECK, P1.PHONE AS XIANPHONE,\n"); 
		sql.append("       P1.ORGAN_NAME AS ORGAN_NAME, P1.ADDRESS AS XIANADDRESS\n"); 
		sql.append("  FROM BASEINFO_PEOPLE T, BPT_OPEN_LETTER B, DIC_BPT_CITY_PHONE P1,\n"); 
		sql.append("       DIC_CITY C\n"); 
		sql.append(" WHERE T.PEOPLE_ID = B.PEOPLE_ID AND T.APANAGE_CODE = C.ID AND\n"); 
		sql.append("       ? = P1.ORGAN_CODE");
		String peopleId = (String)pset.getParameter("peopleId");
		if(peopleId != null && !"".equals(peopleId)) {
			sql.append(" and t.people_id = ? ");
		}
		String applyId = (String)pset.getParameter("applyId");
		if(applyId != null && !"".equals(applyId)) {
			sql.append(" and b.apply_id= ? ");
		}
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},new Object[]{organId,peopleId,applyId},true);
	}
	/**
	 * 老烈子女公示书打印
	 * @param pset
	 * @return
	 */
	public DataSet queryMartyData(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		String organId = (String)pset.getParameter("organId");
		organId = organId.substring(0, 6)+"000000";
		sql.append("SELECT T.NAME,\n");
		sql.append("        (CASE T.SEX  WHEN '1' THEN  '男'  WHEN '2' THEN  '女' END) AS SEX,\n"); 
		sql.append("          T.BIRTHDAY, C.FULL_NAME || T.ADDRESS AS ADDRESS,T.WORK_UNIT_NAME,\n"); 
		sql.append("          B.OPEN_DATE, B.OPENEND_DATE, B.OPENSTART_DATE, B.OPEN_DAYS,\n"); 
		sql.append("         P1.PHONE AS XIANPHONE, P1.ORGAN_NAME AS ORGAN_NAME, P1.ADDRESS AS XIANADDRESS,\n"); 
		sql.append("       CASE O.STATUS_TYPE WHEN '1' THEN '部分60周岁以上烈士子女' WHEN '2' THEN '部分60周岁以上错杀被平反人员子女' END AS STATUS_TYPE,\n"); 
		sql.append("        O.LEZSW_NAME, O.SACRIFICE_DATE, O.LEZSW_APPROVE_DATE\n"); 
		sql.append("  FROM BASEINFO_PEOPLE T, BPT_OPEN_LETTER B, DIC_BPT_CITY_PHONE P1,\n"); 
		sql.append("       DIC_CITY C,BPT_PEOPLE_MARTYR_OFFSPRING O\n"); 
		sql.append(" WHERE T.PEOPLE_ID = B.PEOPLE_ID AND T.APANAGE_CODE = C.ID  AND T.PEOPLE_ID = O.PEOPLE_ID AND\n"); 
		sql.append("       ? = P1.ORGAN_CODE");
		String peopleId = (String)pset.getParameter("peopleId");
		if(peopleId != null && !"".equals(peopleId)) {
			sql.append(" and t.people_id = ? ");
		}
		String applyId = (String)pset.getParameter("applyId");
		if(applyId != null && !"".equals(applyId)) {
			sql.append(" and b.apply_id= ? ");
		}
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},new Object[]{organId,peopleId,applyId},true);
	}
	/**
	 * 60岁退役士兵公示书打印
	 * @param pset
	 * @return
	 */
	public DataSet querySoldierData(ParameterSet pset) {
		StringBuffer sql = new StringBuffer();
		String organId = (String)pset.getParameter("organId");
		organId = organId.substring(0, 6)+"000000";
		sql.append("SELECT T.NAME,\n");
		sql.append("        (CASE T.SEX  WHEN '1' THEN  '男'  WHEN '2' THEN  '女' END) AS SEX,\n"); 
		sql.append("          T.BIRTHDAY, C.FULL_NAME || T.ADDRESS AS ADDRESS,T.WORK_UNIT_NAME,\n"); 
		sql.append("          B.OPEN_DATE, B.OPENEND_DATE, B.OPENSTART_DATE, B.OPEN_DAYS,\n"); 
		sql.append("         P1.PHONE AS XIANPHONE, P1.ORGAN_NAME AS ORGAN_NAME, P1.ADDRESS AS XIANADDRESS,\n"); 
		sql.append("          O.CONSCRIPT_DATE,O.DECRUITMENT_DATE, O.SOLDIER_YEARS\n"); 
		sql.append("  FROM BASEINFO_PEOPLE T, BPT_OPEN_LETTER B, DIC_BPT_CITY_PHONE P1,\n"); 
		sql.append("       DIC_CITY C,BPT_PEOPLE_RETIRED_SOLDIER O\n"); 
		sql.append(" WHERE T.PEOPLE_ID = B.PEOPLE_ID AND T.APANAGE_CODE = C.ID  AND T.PEOPLE_ID = O.PEOPLE_ID AND\n"); 
		sql.append("       ? = P1.ORGAN_CODE");
		String peopleId = (String)pset.getParameter("peopleId");
		if(peopleId != null && !"".equals(peopleId)) {
			sql.append(" and t.people_id = ? ");
		}
		String applyId = (String)pset.getParameter("applyId");
		if(applyId != null && !"".equals(applyId)) {
			sql.append(" and b.apply_id= ? ");
		}
		return this.executeDataset(sql.toString(),new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},new Object[]{organId,peopleId,applyId},true);
	}
}
