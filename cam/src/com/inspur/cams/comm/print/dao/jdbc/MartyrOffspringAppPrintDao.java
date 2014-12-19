package com.inspur.cams.comm.print.dao.jdbc;

import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.baseinfo.data.BaseinfoPeople;
import com.inspur.cams.comm.print.dao.IPrintDao;


/**
 * @title:MartyrOffspringAppPrintDao
 * @description:部分烈士（错杀被平反人员）子女 审批表打印
 * @author:
 * @since:2011-05-31
 * @version:1.0 
*/
 public class MartyrOffspringAppPrintDao extends IPrintDao{

	@Override 
	protected Class<BaseinfoPeople> getEntityClass() {
		return BaseinfoPeople.class;
	}
	ToDate td = new ToDate();
	@SuppressWarnings("unchecked")
	public DataSet queryData(ParameterSet pst) {
		DataSet ds = new DataSet();
		StringBuffer bf = new StringBuffer();

		bf.append("SELECT B.PHOTO_ID, B.PEOPLE_ID, B.FAMILY_ID, B.NAME,\n");
		bf.append("       (CASE B.SEX\n"); 
		bf.append("          WHEN '1' THEN\n"); 
		bf.append("           '男'\n"); 
		bf.append("          WHEN '2' THEN\n"); 
		bf.append("           '女'\n"); 
		bf.append("        END) AS SEX, N.NAME AS NATION, B.BIRTHDAY, B.ID_CARD, B.TEL_MOBILE,\n"); 
		bf.append("       C.FULL_NAME DOMICILE_NAME, Y.FULL_NAME APANAGE_NAME,\n"); 
		bf.append("       (CASE M.STATUS_TYPE\n"); 
		bf.append("          WHEN '1' THEN\n"); 
		bf.append("           '部分60周岁以上烈士子女'\n"); 
		bf.append("          WHEN '2' THEN\n"); 
		bf.append("           '部分60周岁以上错杀被平反人员子女'\n"); 
		bf.append("        END) AS STATUS_TYPE, M.LEZSW_NAME, M.SACRIFICE_DATE,\n"); 
		bf.append("       M.LEZSW_APPROVE_DATE,\n"); 
		bf.append("       (CASE M.RELATIONSHIP\n"); 
		bf.append("          WHEN '1' THEN\n"); 
		bf.append("           '父子'\n"); 
		bf.append("          WHEN '2' THEN\n"); 
		bf.append("           '父女'\n"); 
		bf.append("          WHEN '3' THEN\n"); 
		bf.append("           '母子'\n"); 
		bf.append("          WHEN '4' THEN\n"); 
		bf.append("           '母女'\n"); 
		bf.append("        END) AS RELATIONSHIP,\n"); 
		bf.append("       (CASE M.HOLDER_FLAG\n"); 
		bf.append("          WHEN '0' THEN\n"); 
		bf.append("           '否'\n"); 
		bf.append("          WHEN '1' THEN\n"); 
		bf.append("           '是'\n"); 
		bf.append("        END) AS HOLDER_FLAG,\n"); 
		bf.append("       (CASE M.ENJOYED_TREAT_FLAG\n"); 
		bf.append("          WHEN '0' THEN\n"); 
		bf.append("           '否'\n"); 
		bf.append("          WHEN '1' THEN\n"); 
		bf.append("           '是'\n"); 
		bf.append("        END) AS ENJOYED_TREAT_FLAG, B.MARTYR_OFFSPRING_NO,\n"); 
		bf.append("       (CASE B.PENSION_CODE\n"); 
		bf.append("          WHEN '1' THEN\n"); 
		bf.append("           '新型农村养老保险'\n"); 
		bf.append("          WHEN '2' THEN\n"); 
		bf.append("           '城镇居民养老保险'\n"); 
		bf.append("          WHEN '3' THEN\n"); 
		bf.append("           '城镇职工基本养老保险'\n"); 
		bf.append("          WHEN '4' THEN\n"); 
		bf.append("           '商业保险'\n"); 
		bf.append("          WHEN '5' THEN\n"); 
		bf.append("           '无'\n"); 
		bf.append("          WHEN '6' THEN\n"); 
		bf.append("           '社会统筹'\n"); 
		bf.append("          WHEN '7' THEN\n"); 
		bf.append("           '其他'\n"); 
		bf.append("        END) AS PENSION_CODE, A.ACCEPT_INCHARGE,\n"); 
		bf.append("       A.ACCEPT_ADVICE, A.CHECK_INCHARGE, A.CHECK_ADVICE,\n"); 
		
		bf.append("       A.AUDIT_INCHARGE, A.AUDIT_ADVICE,\n"); 
		bf.append(  td.todate("a.CHECK_DATE")+" CHECK_DATE,");
		bf.append(  td.todate("a.ACCEPT_DATE")+" ACCEPT_DATE,");
		bf.append(  td.todate("a.AUDIT_DATE")+" AUDIT_DATE ");
		bf.append("  FROM BASEINFO_PEOPLE B, BPT_PEOPLE P, BPT_PEOPLE_MARTYR_OFFSPRING M,\n"); 
		bf.append("       BPT_APPLY_MARTYR_OFFSPRING A, DIC_NATION N, DIC_CITY C, DIC_CITY Y\n"); 
		bf.append(" WHERE B.PEOPLE_ID = P.PEOPLE_ID AND P.PEOPLE_ID = M.PEOPLE_ID AND\n"); 
		bf.append("       M.PEOPLE_ID = A.PEOPLE_ID AND B.NATION = N.CODE AND\n"); 
		bf.append("       B.DOMICILE_CODE = C.ID AND B.APANAGE_CODE = Y.ID AND\n"); 
		bf.append("       B.MARTYR_OFFSPRING_FLAG = ?");

		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		typeList.add(Types.VARCHAR);
		argsList.add("1");
		
		String peopleId = (String)pst.getParameter("peopleId");
		if(peopleId != null && !"".equals(peopleId)) {
			bf.append(" and B.people_id =?");
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
		}
		String applyId = (String)pst.getParameter("applyId");
		if(applyId != null && !"".equals(applyId)) {
			bf.append(" and A.apply_id =?");
			typeList.add(Types.VARCHAR);
			argsList.add(applyId);
		}
		if(typeList.size() != 0 && argsList.size()!= 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(bf.toString(),types,args, true);
		} else {
			ds = this.executeDataset(bf.toString(), true);
		}
		return  ds;
	}
	@SuppressWarnings("unchecked")
	public DataSet querySoldierData(ParameterSet pst) {
		DataSet ds = new DataSet();
		StringBuffer bf = new StringBuffer();
		bf.append("SELECT B.PHOTO_ID, B.PEOPLE_ID, B.FAMILY_ID, B.NAME, C.FULL_NAME||B.DOMICILE_ADDRESS  DOMICILE_ADDRESS,\n");
		bf.append("       (CASE B.SEX\n"); 
		bf.append("          WHEN '1' THEN\n"); 
		bf.append("           '男'\n"); 
		bf.append("          WHEN '2' THEN\n"); 
		bf.append("           '女'\n"); 
		bf.append("        END) AS SEX, N.NAME AS NATION, B.BIRTHDAY, B.ID_CARD, B.TEL_MOBILE,\n"); 
		bf.append("       M.RETIRED_NO,\n"); 
		bf.append("       B.Address,\n"); 
		bf.append("        M.CONSCRIPT_DATE,\n"); 
		bf.append("        M.DECRUITMENT_DATE,\n"); 
		bf.append("        M.SOLDIER_START_DATE,\n"); 
		bf.append("        M.SOLDIER_END_DATE,\n"); 
		bf.append("        M.SOLDIER_YEARS,\n"); 
		bf.append("       (CASE B.PENSION_CODE\n"); 
		bf.append("          WHEN '1' THEN\n"); 
		bf.append("           '新型农村养老保险'\n"); 
		bf.append("          WHEN '2' THEN\n"); 
		bf.append("           '城镇居民养老保险'\n"); 
		bf.append("          WHEN '3' THEN\n"); 
		bf.append("           '城镇职工基本养老保险'\n"); 
		bf.append("          WHEN '4' THEN\n"); 
		bf.append("           '商业保险'\n"); 
		bf.append("          WHEN '5' THEN\n"); 
		bf.append("           '无'\n"); 
		bf.append("          WHEN '6' THEN\n"); 
		bf.append("           '社会统筹'\n"); 
		bf.append("          WHEN '7' THEN\n"); 
		bf.append("           '其他'\n"); 
		bf.append("        END) AS PENSION, A.ACCEPT_INCHARGE,\n"); 
		bf.append("       A.ACCEPT_ADVICE, A.CHECK_INCHARGE, A.CHECK_ADVICE,\n"); 
		bf.append("       A.AUDIT_INCHARGE, A.AUDIT_ADVICE,\n"); 
		bf.append(  td.todate("a.CHECK_DATE")+" CHECK_DATE,");
		bf.append(  td.todate("a.ACCEPT_DATE")+" ACCEPT_DATE,");
		bf.append(  td.todate("a.AUDIT_DATE")+" AUDIT_DATE ");
		bf.append("  FROM BASEINFO_PEOPLE B, BPT_PEOPLE P, BPT_PEOPLE_RETIRED_SOLDIER  M,\n"); 
		bf.append("       BPT_APPLY_MARTYR_OFFSPRING A, DIC_NATION N, DIC_CITY C\n"); 
		bf.append(" WHERE B.PEOPLE_ID = P.PEOPLE_ID AND P.PEOPLE_ID = M.PEOPLE_ID AND\n"); 
		bf.append("       M.PEOPLE_ID = A.PEOPLE_ID AND B.NATION = N.CODE AND\n"); 
		bf.append("       B.RETIRED_FLAG = ?  AND C.ID = B.DOMICILE_CODE");

		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		typeList.add(Types.VARCHAR);
		argsList.add("1");
		
		String peopleId = (String)pst.getParameter("peopleId");
		if(peopleId != null && !"".equals(peopleId)) {
			bf.append(" and B.people_id =?");
			typeList.add(Types.VARCHAR);
			argsList.add(peopleId);
		}
		String applyId = (String)pst.getParameter("applyId");
		if(applyId != null && !"".equals(applyId)) {
			bf.append(" and A.apply_id =?");
			typeList.add(Types.VARCHAR);
			argsList.add(applyId);
		}
		if(typeList.size() != 0 && argsList.size()!= 0) {
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++) {
				types[i]=(Integer)(typeList.get(i));
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			ds = this.executeDataset(bf.toString(),types,args, true);
		} else {
			ds = this.executeDataset(bf.toString(), true);
		}
		return  ds;
	}
}
