package com.inspur.cams.prs.print;

import java.sql.Types;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.print.dao.IPrintDao;
import com.inspur.cams.prs.prsretiredsoldiers.dao.PrsRetiredSoldiers;

public class PrintDao extends IPrintDao {

	@Override
	public DataSet queryData(ParameterSet pset) {
		String type = (String) pset.getParameter("type");
		String soldierId = (String) pset.getParameter("soldierId");
		StringBuffer bf = new StringBuffer();
		if("01".equalsIgnoreCase(type)){
			bf.append("SELECT T.NAME, T.NAME AS NAME_1, T.NAME AS NAME_2,");
			bf.append("(CASE t.SEX WHEN '1' THEN '男' WHEN '2' THEN '女' END) AS SEX,");
			bf.append("T.HUKOU_LOCATION HUKOULOCATION,T.HUKOU_LOCATION AS HUKOULOCATION_1,T.FILE_NUM AS NO ,");
			bf.append("T.FILE_NUM AS NO_1,T.BIRTHDAY,T.BIRTHPLACE,(CASE T.COUTRAL_LEVEL " );
			bf.append(" WHEN '10'THEN '研究生' ");
			bf.append(" WHEN '20'THEN '大学本科' ");
			bf.append(" WHEN '30'THEN '大学专科和专科学校' ");
			bf.append(" WHEN '40'THEN '中等专业学校或中等技术学校' ");
			bf.append(" WHEN '50'THEN '技工学校' " );
			bf.append(" WHEN '60'THEN '高中' " );
			bf.append(" WHEN '70'THEN '初中' " );
			bf.append(" WHEN '80'THEN '小学' ");
			bf.append(" WHEN '90'THEN '文盲或半文盲' END ) AS COUTRALLEVEL ,N.NAME NATON , ");
			bf.append(" TO_CHAR(SYSDATE ,'YYYY') YEAR,  " );
			bf.append(" TO_CHAR(SYSDATE ,'YYYY') YEAR_1, " );
			bf.append(" TO_CHAR(SYSDATE,'MM') MONTH, " );
			bf.append(" TO_CHAR(SYSDATE,'MM') MONTH_1, " );
			bf.append(" TO_CHAR(SYSDATE,'DD') DAY, " );
			bf.append(" TO_CHAR(SYSDATE,'DD') DAY_1 " );
			bf.append("FROM PRS_RETIRED_SOLDIERS T  , DIC_NATION N ");
			bf.append(" WHERE  T.SOLDIERS_ID =? ");
			bf.append(" AND  N.CODE = T.NATON  ");
			
		}else if("02".equalsIgnoreCase(type)){
			bf.append("SELECT T.NAME,T.NAME AS NAME_1,");
			bf.append("T.SERVED_ARMY AS ARMY,T.FILE_NUM NO, T.FILE_NUM NO_1,");
			bf.append("SUBSTR(T.ENLIST_TIME,0,4) ENLIST_YEAR,");
			bf.append("SUBSTR(T.ENLIST_TIME,6,2) ENLIST_MONTH,");
			bf.append("SUBSTR(T.ENLIST_TIME,9,2) ENLIST_DAY,");
			bf.append("SUBSTR(T.RETIRED_TIME,0,4) RETIRED_YEAR,");
			bf.append("SUBSTR(T.RETIRED_TIME,6,2) RETIRED_MONTH,");
			bf.append("SUBSTR(T.RETIRED_TIME,9,2) RETIRED_DAY,");
			bf.append("P.TRANSACT_DATE,CASE WHEN  P.TRANSACT_DATE IS NULL THEN '' ELSE SUBSTR(P.TRANSACT_DATE, 0, 4) || '年' ||  SUBSTR(P.TRANSACT_DATE, 6, 2) || '月' || SUBSTR(P.TRANSACT_DATE, 9, 2) || '日' end TRANSACT_YEAR,");
			//bf.append("SUBSTR(P.TRANSACT_DATE,6,2) TRANSACT_MONTH,");
			//bf.append("SUBSTR(P.TRANSACT_DATE,9,2) TRANSACT_DAY,");
			bf.append("P.EMPLOYMENT_COMPANY COMPANY,");
			bf.append("P.EMPLOYMENT_COMPANY COMPANY_1,");
			bf.append("GETNAME(T.WHERE_PLACEMEN) MINZHENG,");
			bf.append("TO_CHAR(SYSDATE,'YYYY') YEAR,");
			bf.append("TO_CHAR(SYSDATE,'MM')MONTH,");
			bf.append("TO_CHAR(SYSDATE,'DD')DAY");
			bf.append(" FROM PRS_RETIRED_SOLDIERS T, PRS_SOLDIERS_PLACEMENT P ");
			bf.append(" WHERE T.SOLDIERS_ID = P.SOLDIERS_ID ");
			bf.append(" AND T.SOLDIERS_ID = ? ");
		}else if("03".equalsIgnoreCase(type) ){
		    bf.append("SELECT S.NAME,S.NAME AS NAME_1,");
            bf.append("S.FILE_NUM NO,S.FILE_NUM NO_1,");
            bf.append("TO_CHAR(SYSDATE, 'YYYY') YEAR_2,");
            bf.append("TO_CHAR(SYSDATE, 'YYYY') YEAR_1,");
            bf.append("TO_CHAR(SYSDATE, 'YYYY') YEAR,");
            bf.append("TO_CHAR(SYSDATE, 'MM') MONTH,");
            bf.append("TO_CHAR(SYSDATE, 'DD') DAY,");
            bf.append("TO_CHAR(SYSDATE, 'YYYY') YEAR_3,");
            bf.append("GETNAME(S.WHERE_PLACEMEN) MINZHENG,");
            bf.append("GETNAME(S.WHERE_PLACEMEN) MINZHENG_1,");
            bf.append("TO_CHAR(SYSDATE, 'MM') MONTH_1,");
            bf.append("TO_CHAR(SYSDATE, 'DD') DAY_1,");
            bf.append("T.TRAINING_INSTITUTIONS SCHOOL,");
            bf.append("T.TRAINING_INSTITUTIONS SCHOOL_1 ");
            bf.append("FROM PRS_RETIRED_SOLDIERS S,PRS_SOLDIERS_TRAIN T");
            bf.append(" WHERE T.SOLDIERS_ID = S.SOLDIERS_ID ");
            bf.append(" AND T.SOLDIERS_ID = ? ");
		  
		}else{
		    bf.append("SELECT S.NAME,");
            bf.append("S.FILE_NUM NO,");
            bf.append("S.IDCARD_NO IDCARD,");
            bf.append("N.NAME  NATION,");
            bf.append("S.ENLIST_PLACE ENLISTPLACE,");
            bf.append("S.ENLIST_TIME ENLISTTIME,");
            bf.append("M.NAME MILITARYREGION,");
            bf.append("S.RETIRED_TIME RETIREDTIME,");
            bf.append("S.SERVED_ARMY SERVEDARMY,");
            bf.append("(CASE S.SEX WHEN '1'THEN '男' WHEN '2' THEN '女' ELSE '' END) AS SEX,");
            bf.append("S.TEL TEL,");
            bf.append("S.ADDRESS ADDRESS,");
            bf.append("S.VETERANS_CERTIFICATE_NO VETERANSNO,");
            bf.append("GETFULLNAME(S.WHERE_PLACEMEN) WHEREPLACEMEN ");
            bf.append("FROM PRS_RETIRED_SOLDIERS S , DIC_NATION N ,");
            bf.append(" DIC_MILITARY_REGION_CODE M  WHERE ");
            bf.append("  S.SOLDIERS_ID = ? ");
            bf.append(" AND  N.CODE = S.NATON  ");
            bf.append(" AND M.CODE = S.SERVED_MILITARY_REGION ");
            //bf.append(" AND C.ID = S.ENLIST_PLACE ");
		}
		DataSet ds = this.executeDataset(bf.toString(),new int[]{Types.VARCHAR},new Object[]{soldierId}, true);
		return ds;
	}

	@SuppressWarnings("unchecked")
	@Override
	protected Class getEntityClass() {
		return PrsRetiredSoldiers.class;
	}

}
