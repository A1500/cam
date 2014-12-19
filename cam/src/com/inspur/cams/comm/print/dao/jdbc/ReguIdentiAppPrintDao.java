package com.inspur.cams.comm.print.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.print.dao.IPrintDao;

/**
 * 打印证书
 *
 */
public class ReguIdentiAppPrintDao extends IPrintDao{

	@Override
	protected Class<BaseinfoPeople> getEntityClass() {
		return BaseinfoPeople.class;
	}
	public DataSet queryData(ParameterSet pset) {
		DataSet ds = null;
		List<Integer> typeList = new ArrayList<Integer>();
		List<Object> argsList = new ArrayList<Object>();
		String objectType = (String) pset.getParameter("objectType");
		String peopleId = (String)pset.getParameter("peopleId");
		StringBuffer bf = new StringBuffer();
		if (objectType.equals("11")||objectType.equals("12")||objectType.equals("13")||objectType.equals("14")||objectType.equals("15")) {//伤残查询
			bf.append("SELECT A.PEOPLE_ID, A.NAME AS NAME,\n");
			bf.append("       (CASE A.SEX\n"); 
			bf.append("          WHEN '1' THEN '男'\n"); 
			bf.append("          WHEN '2' THEN '女'\n"); 
			bf.append("        END) AS SEX,\n"); 
			bf.append("       CASE\n"); 
			bf.append("         WHEN M.AGE < '16' THEN '5年'\n"); 
			bf.append("         WHEN M.AGE >= '16' AND M.AGE <= '25' THEN '10年'\n"); 
			bf.append("         WHEN M.AGE >= '26' AND M.AGE <= '45' THEN '20年'\n"); 
			bf.append("         WHEN M.AGE >= '46' THEN '长期'\n"); 
			bf.append("       END VALIDITY_PERIOD,\n"); 
			bf.append("       (SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL) CERTIFICATE_DATE,\n"); 
			bf.append("       A.BIRTHDAY, A.ID_CARD, D.NAME || F.NAME AS TOWN_NAME,\n"); 
			bf.append("       E.NAME AS DOMICILE_NAME, A.DOMICILE_ADDRESS,\n"); 
			bf.append("       (CASE A.DISABILITY_CASE_CODE\n"); 
			bf.append("          WHEN '1' THEN '因战'\n"); 
			bf.append("          WHEN '2' THEN '因公'\n"); 
			bf.append("          WHEN '3' THEN '因病'\n"); 
			bf.append("        END) AS DISABILITY_CASE_CODE,\n"); 
			bf.append("       (CASE A.DISABILITY_LEVEL_CODE\n"); 
			bf.append("          WHEN '01' THEN '一级'\n"); 
			bf.append("          WHEN '02' THEN '二级'\n"); 
			bf.append("          WHEN '03' THEN '三级'\n"); 
			bf.append("          WHEN '04' THEN '四级'\n"); 
			bf.append("          WHEN '05' THEN '五级'\n"); 
			bf.append("          WHEN '06' THEN '六级'\n"); 
			bf.append("          WHEN '07' THEN '七级'\n"); 
			bf.append("          WHEN '08' THEN '八级'\n"); 
			bf.append("          WHEN '09' THEN '九级'\n"); 
			bf.append("          WHEN '10' THEN '十级'\n"); 
			bf.append("        END) AS DISABILITY_LEVEL_CODE, A.DISABILITY_NO,C.DISABILITY_BODY, \n"); 
			bf.append("       CASE\n"); 
			bf.append("         WHEN B.DISABILITY_TYPE_CODE != '00' THEN DISABILITY_TYPE_CODE\n"); 
			bf.append("         WHEN B.DEPENDANT_TYPE_CODE != '00' THEN DEPENDANT_TYPE_CODE\n"); 
			bf.append("         WHEN B.REDA_TYPE_CODE != '00' THEN REDA_TYPE_CODE\n"); 
			bf.append("         WHEN B.DEMOBILIZED_TYEP_CODE != '00' THEN DEMOBILIZED_TYEP_CODE\n"); 
			bf.append("         WHEN B.WAR_TYPE_CODE != '00' THEN WAR_TYPE_CODE\n"); 
			bf.append("       END AS OBJECT_TYPE, C.DISABILITY_GENUS_CODE\n"); 
			bf.append("  FROM BASEINFO_PEOPLE A, DIC_CITY D, DIC_CITY F, DIC_CITY E, BPT_PEOPLE B,\n"); 
			bf.append("       BPT_PEOPLE_DISABILITY C,\n"); 
			bf.append("       (SELECT GETAGE(W.BIRTHDAY) AGE\n"); 
			bf.append("           FROM BASEINFO_PEOPLE W\n"); 
			bf.append("          WHERE W.PEOPLE_ID = ?) M\n"); 
			bf.append(" WHERE A.PEOPLE_ID = B.PEOPLE_ID AND A.PEOPLE_ID = C.PEOPLE_ID AND\n"); 
			bf.append("       A.DISABILITY_FLAG = ? AND SUBSTR(A.DOMICILE_CODE, 1, 4) || ? = D.ID AND\n"); 
			bf.append("       SUBSTR(A.DOMICILE_CODE, 1, 6) || ? = F.ID AND A.DOMICILE_CODE = E.ID");
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
			typeList.add(Types.VARCHAR);
			argsList.add("1");
			typeList.add(Types.VARCHAR);
			argsList.add("00000000");
			typeList.add(Types.VARCHAR);
			argsList.add("000000");
		}else if (objectType.equals("21")||objectType.equals("22")||objectType.equals("23")) {//三属
			bf.append("SELECT A.NAME AS NAME,\n");
			bf.append("       (CASE A.SEX\n"); 
			bf.append("          WHEN '1' THEN '男'\n"); 
			bf.append("          WHEN '2' THEN '女'\n"); 
			bf.append("        END) AS SEX,\n"); 
			bf.append("       (SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL) CERTIFICATE_DATE,\n"); 
			bf.append("       A.BIRTHDAY, A.ID_CARD, A.DOMICILE_ADDRESS,\n"); 
			bf.append("       E.NAME || F.NAME AS TOWN_NAME, C.NAME AS DOMICILE_NAME,\n"); 
			bf.append("       A.DEPENDANT_NO, D.LEZSW_NAME, D.LEZSW_CERTIFICATE_ID,\n"); 
			bf.append("       (CASE D.RELATIONSHIP\n"); 
			bf.append("          WHEN '1' THEN '父母（抚养人）'\n"); 
			bf.append("          WHEN '2' THEN '子女'\n"); 
			bf.append("          WHEN '3' THEN '配偶'\n"); 
			bf.append("          WHEN '4' THEN '兄弟姐妹'\n"); 
			bf.append("        END) AS RELATIONSHIP\n"); 
			bf.append("  FROM BASEINFO_PEOPLE A, BPT_PEOPLE_DEPENDANT D, BPT_PEOPLE T, DIC_CITY C,\n"); 
			bf.append("       DIC_CITY E, DIC_CITY F\n"); 
			bf.append(" WHERE A.PEOPLE_ID = D.PEOPLE_ID AND D.PEOPLE_ID = T.PEOPLE_ID AND\n"); 
			bf.append("       DOMICILE_CODE = C.ID AND A.DEPENDANT_FLAG = ? AND\n"); 
			bf.append("       A.PERSONAL_STATS_TAG != ? AND\n"); 
			bf.append("       SUBSTR(DOMICILE_CODE, 1, 4) || ? = E.ID AND\n"); 
			bf.append("       SUBSTR(DOMICILE_CODE, 1, 6) || ? = F.ID");
			typeList.add(Types.VARCHAR);
			argsList.add("1");
			typeList.add(Types.VARCHAR);
			argsList.add("4");
			typeList.add(Types.VARCHAR);
			argsList.add("00000000");
			typeList.add(Types.VARCHAR);
			argsList.add("000000");
		}else if (objectType.equals("41")) {//在乡复员军人
			bf.append("SELECT A.NAME,\n");
			bf.append("       (CASE A.SEX\n"); 
			bf.append("          WHEN '1' THEN '男'\n"); 
			bf.append("          WHEN '2' THEN '女'\n"); 
			bf.append("        END) AS SEX,\n"); 
			bf.append("       (SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL) CERTIFICATE_DATE,\n"); 
			bf.append("       A.BIRTHDAY, A.ID_CARD, A.DOMICILE_ADDRESS,\n"); 
			bf.append("       E.NAME || F.NAME AS TOWN_NAME, D.NAME AS DOMICILE_NAME,\n"); 
			bf.append("       A.DEMOBILIZED_NO\n"); 
			bf.append("  FROM BASEINFO_PEOPLE A, BPT_PEOPLE B, BPT_PEOPLE_DEMOBILIZED C, DIC_CITY D,\n"); 
			bf.append("       DIC_CITY E, DIC_CITY F\n"); 
			bf.append(" WHERE A.PEOPLE_ID = B.PEOPLE_ID AND A.PEOPLE_ID = C.PEOPLE_ID AND\n"); 
			bf.append("       A.DEMOBILIZED_FLAG = ? AND A.PERSONAL_STATS_TAG != ? AND\n"); 
			bf.append("       A.DOMICILE_CODE = D.ID AND SUBSTR(DOMICILE_CODE, 1, 4) || ? = E.ID AND\n"); 
			bf.append("       SUBSTR(DOMICILE_CODE, 1, 6) || ? = F.ID");
			typeList.add(Types.VARCHAR);
			argsList.add("1");
			typeList.add(Types.VARCHAR);
			argsList.add("4");
			typeList.add(Types.VARCHAR);
			argsList.add("00000000");
			typeList.add(Types.VARCHAR);
			argsList.add("000000");
		}else if (objectType.equals("42")) {//带病回乡
			bf.append("SELECT A.NAME,\n");
			bf.append("       (CASE A.SEX\n"); 
			bf.append("          WHEN '1' THEN '男'\n"); 
			bf.append("          WHEN '2' THEN '女'\n"); 
			bf.append("        END) AS SEX,\n"); 
			bf.append("       (SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL) CERTIFICATE_DATE,\n"); 
			bf.append("       A.BIRTHDAY, C.CONSCRIPT_DATE, C.DECRUITMENT_DATE, A.ID_CARD,\n"); 
			bf.append("       A.DOMICILE_ADDRESS, E.NAME || F.NAME AS TOWN_NAME,\n"); 
			bf.append("       D.NAME AS DOMICILE_NAME, A.DEMOBILIZED_NO\n"); 
			bf.append("  FROM BASEINFO_PEOPLE A, BPT_PEOPLE B, BPT_PEOPLE_DEMOBILIZED_ILLNESS C,\n"); 
			bf.append("       DIC_CITY D, DIC_CITY E, DIC_CITY F\n"); 
			bf.append(" WHERE A.PEOPLE_ID = C.PEOPLE_ID AND A.PEOPLE_ID = B.PEOPLE_ID AND\n"); 
			bf.append("       A.DEMOBILIZED_FLAG = ? AND A.PERSONAL_STATS_TAG != ? AND\n"); 
			bf.append("       A.DOMICILE_CODE = D.ID AND SUBSTR(DOMICILE_CODE, 1, 4) || ? = E.ID AND\n"); 
			bf.append("       SUBSTR(DOMICILE_CODE, 1, 6) || ? = F.ID");
			typeList.add(Types.VARCHAR);
			argsList.add("1");
			typeList.add(Types.VARCHAR);
			argsList.add("4");
			typeList.add(Types.VARCHAR);
			argsList.add("00000000");
			typeList.add(Types.VARCHAR);
			argsList.add("000000");
		}else if (objectType.equals("51")) {//参战
			bf.append("SELECT A.NAME,\n");
			bf.append("       (CASE A.SEX\n"); 
			bf.append("          WHEN '1' THEN '男'\n"); 
			bf.append("          WHEN '2' THEN '女'\n"); 
			bf.append("        END) AS SEX,\n"); 
			bf.append("       (SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL) CERTIFICATE_DATE,\n"); 
			bf.append("       A.BIRTHDAY, D.CONSCRIPTC_DATE, D.DECRUITMENT_DATE, A.ID_CARD,\n"); 
			bf.append("       A.DOMICILE_ADDRESS, E.NAME || F.NAME AS TOWN_NAME,\n"); 
			bf.append("       C.NAME AS DOMICILE_NAME, A.WAR_NO\n"); 
			bf.append("  FROM BASEINFO_PEOPLE A, BPT_PEOPLE_WAR D, BPT_PEOPLE T, DIC_CITY C,\n"); 
			bf.append("       DIC_CITY E, DIC_CITY F\n"); 
			bf.append(" WHERE A.PEOPLE_ID = D.PEOPLE_ID AND D.PEOPLE_ID = T.PEOPLE_ID AND\n"); 
			bf.append("       DOMICILE_CODE = C.ID AND A.WAR_FLAG = ? AND\n"); 
			bf.append("       A.PERSONAL_STATS_TAG != ? AND T.WAR_TYPE_CODE = ? AND\n"); 
			bf.append("       SUBSTR(DOMICILE_CODE, 1, 4) || ? = E.ID AND\n"); 
			bf.append("       SUBSTR(DOMICILE_CODE, 1, 6) || ? = F.ID");
			typeList.add(Types.VARCHAR);
			argsList.add("1");
			typeList.add(Types.VARCHAR);
			argsList.add("4");
			typeList.add(Types.VARCHAR);
			argsList.add("51");
			typeList.add(Types.VARCHAR);
			argsList.add("00000000");
			typeList.add(Types.VARCHAR);
			argsList.add("000000");
		}else if (objectType.equals("61")) {//参试
			bf.append("SELECT A.NAME,\n");
			bf.append("       (CASE A.SEX\n"); 
			bf.append("          WHEN '1' THEN '男'\n"); 
			bf.append("          WHEN '2' THEN '女'\n"); 
			bf.append("        END) AS SEX,\n"); 
			bf.append("       (SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL) CERTIFICATE_DATE,\n"); 
			bf.append("       A.BIRTHDAY, D.CONSCRIPTC_DATE, D.DECRUITMENT_DATE, A.ID_CARD,\n"); 
			bf.append("       A.DOMICILE_ADDRESS, A.DOMICILE_ADDRESS, E.NAME || F.NAME AS TOWN_NAME,\n"); 
			bf.append("       C.NAME AS DOMICILE_NAME, A.WAR_NO\n"); 
			bf.append("  FROM BASEINFO_PEOPLE A, BPT_PEOPLE_TESTED D, BPT_PEOPLE T, DIC_CITY C,\n"); 
			bf.append("       DIC_CITY E, DIC_CITY F\n"); 
			bf.append(" WHERE A.PEOPLE_ID = D.PEOPLE_ID AND D.PEOPLE_ID = T.PEOPLE_ID AND\n"); 
			bf.append("       DOMICILE_CODE = C.ID AND A.WAR_FLAG = ? AND\n"); 
			bf.append("       A.PERSONAL_STATS_TAG != ? AND T.WAR_TYPE_CODE = ? AND\n"); 
			bf.append("       SUBSTR(DOMICILE_CODE, 1, 4) || ? = E.ID AND\n"); 
			bf.append("       SUBSTR(DOMICILE_CODE, 1, 6) || ? = F.ID");
			typeList.add(Types.VARCHAR);
			argsList.add("1");
			typeList.add(Types.VARCHAR);
			argsList.add("4");
			typeList.add(Types.VARCHAR);
			argsList.add("61");
			typeList.add(Types.VARCHAR);
			argsList.add("00000000");
			typeList.add(Types.VARCHAR);
			argsList.add("000000");
		}
		if(peopleId != null && !"".equals(peopleId)) {
			bf.append(" and A.PEOPLE_ID = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
		}
		if (typeList.size() != 0 && argsList.size() != 0) {
			int[] types = new int[typeList.size()];
			for (int i = 0; i < typeList.size(); i++) {
				types[i] = (Integer) (typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(bf.toString(),types,args,true);
		}
		return  ds;
	}
}
