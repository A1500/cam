package com.inspur.cams.comm.print.dao.jdbc;

import java.sql.Types;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.print.dao.IPrintDao;
/**
 * 临时救助申请表 查找数据用于 打印
 * @author Administrator
 *
 */
public class TemporaryHelpAppPrintDao extends IPrintDao {

	@Override
	protected Class<BaseinfoPeople> getEntityClass() {
		return BaseinfoPeople.class;
	}

	public DataSet queryData(ParameterSet pset) {
		ToDate td = new ToDate();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT B.PHOTO_ID, B.NAME AS NAME,\n");
		sql.append("       (CASE B.SEX\n"); 
		sql.append("          WHEN '1' THEN '男'\n"); 
		sql.append("          WHEN '2' THEN '女'\n"); 
		sql.append("        END) AS SEX, B.ID_CARD, O.NAME AS OBJECT_TYPE,\n"); 
		sql.append("       (SELECT GETAGE(B.BIRTHDAY) FROM DUAL) AGE,\n"); 
		sql.append("       C.FULL_NAME || B.ADDRESS AS ADDRESS, T.FAMILY_NUM,\n"); 
		sql.append("       (CASE T.HELP_TYPE\n"); 
		sql.append("          WHEN '01' THEN '生活困难'\n"); 
		sql.append("          WHEN '02' THEN '住房'\n"); 
		sql.append("          WHEN '03' THEN '医疗困难'\n"); 
		sql.append("          WHEN '04' THEN '其他'\n"); 
		sql.append("        END) AS HELP_TYPE, T.APPLY_MON, T.APPLY_SUBJECT,\n"); 
		sql.append("       T.CHECK_INCHARGE,T.CHECK_ADVICE,T.AUDIT_INCHARGE,T.AUDIT_ADVICE,T.VERIFY_INCHARGE,T.VERIFY_ADVICE, ");
		sql.append(  	   td.todate("T.CHECK_DATE")+" CHECK_DATE,");
		sql.append(  	   td.todate("T.AUDIT_DATE")+" AUDIT_DATE,");
		sql.append(  	   td.todate("T.VERIFY_DATE")+" VERIFY_DATE,");
		sql.append("       T.NOTE \n"); 
		sql.append("  FROM BASEINFO_PEOPLE B, DIC_BPT_OBJECT_TYPE O, BPT_TEMPORARY_HELP T,\n"); 
		sql.append("       DIC_CITY C\n"); 
		sql.append(" WHERE B.PEOPLE_ID = T.PEOPLE_ID AND O.CODE = OBJECT_TYPE AND\n"); 
		sql.append("       B.APANAGE_CODE = C.ID");
		String peopleId = (String)pset.getParameter("peopleId");
		if(peopleId != null && !"".equals(peopleId)) {
			sql.append(" and b.people_id = ? ");
		}
		DataSet ds = this.executeDataset(sql.toString(),new int[]{Types.VARCHAR},new Object[]{peopleId},true);
		return ds;
	}

}
