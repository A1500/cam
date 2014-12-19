package com.inspur.cams.drel.admin.dao.jdbc;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.ProceduresUtil;
import com.inspur.cams.drel.admin.dao.ISamAdminQueryDao;
import com.inspur.cams.drel.archive.baseinfofamilyarchive.data.BaseinfoFamilyArchive;

public class SamAdminQueryDao extends EntityDao<BaseinfoFamilyArchive> implements ISamAdminQueryDao{
	@Override
	protected Class getEntityClass() {
		return BaseinfoFamilyArchive.class;
	}
	/**
    * 查询目前正在享受低保的家庭户数总数、总钱数,城市、农村、五保的户数、钱数，
    * @author zhangdongdong
    * @param pset
    * @return
    */
   public DataSet queryBaseFamilyCaseNow(ParameterSet pset){
	   String areaCode= BspUtil.getOrganCode();
	   StringBuffer sql = new StringBuffer();
	   sql.append("SELECT COUNT,MONEYSUM,PEOPLENUM,DOMICILE_CODE,DOMICILE_NAME,CITYCOUNT,CITYMONEY,");
	   sql.append("CITYPEOPLE,COUNTRYCOUNT,COUNTRYMONEY,COUNTRYPEOPLE,FIVECOUNT,FIVEMONEY,FIVEPEOPLE");
	   sql.append(" FROM (SELECT SUM(COUNT) AS COUNT,");
	   sql.append("        SUM(MONEYSUM) AS MONEYSUM,");
	   sql.append("        SUM(PEOPLENUM) AS PEOPLENUM,");
	   sql.append("'"+areaCode+"' DOMICILE_CODE,");
	   sql.append("        GET_CITY_NAME('"+areaCode+"') DOMICILE_NAME,");
	   sql.append("        SUM(CITYCOUNT) AS CITYCOUNT,");
	   sql.append("        SUM(CITYMONEY) AS CITYMONEY,");
	   sql.append("        SUM(CITYPEOPLE) AS CITYPEOPLE,");
	   sql.append("        SUM(COUNTRYCOUNT) AS COUNTRYCOUNT,");
	   sql.append("        SUM(COUNTRYMONEY) AS COUNTRYMONEY,");
	   sql.append("        SUM(COUNTRYPEOPLE) AS COUNTRYPEOPLE,");
	   sql.append("        SUM(FIVECOUNT) AS FIVECOUNT,");
	   sql.append("        SUM(FIVEMONEY) AS FIVEMONEY,");
	   sql.append("        SUM(FIVEPEOPLE) AS FIVEPEOPLE");
	   sql.append("   FROM (SELECT COUNT(*) COUNT,");
	   sql.append("            CAST(SUM(NVL(A.ASSISTANCE_MONEY, 0) +");
	   sql.append("                     NVL(A.ASSISTANCE_CLASS_MONEY, 0)) / 10000 AS DECIMAL(10, 2)) MONEYSUM,");
	   sql.append("            SUM(NVL(A.ASSISTANCE_PEOPLE_NUM, 0)) PEOPLENUM,");
	   sql.append("            RPAD(SUBSTR(A.DOMICILE_CODE, 1, "+getSubstrIndex(areaCode)+"), 12, '0') DOMICILE_CODE,");
	   sql.append("            GET_CITY_NAME(RPAD(SUBSTR(A.DOMICILE_CODE, 1,"+getSubstrIndex(areaCode)+"),12,'0')) DOMICILE_NAME,");
	   sql.append("            SUM(CASE WHEN A.ASSISTANCE_TYPE = '01' THEN 1 ELSE 0 END) CITYCOUNT,");
	   sql.append("            CAST(SUM(CASE WHEN A.ASSISTANCE_TYPE = '01' THEN (NVL(A.ASSISTANCE_MONEY, 0) +");
	   sql.append("                        NVL(A.ASSISTANCE_CLASS_MONEY, 0)) ELSE 0 END) / 10000 AS DECIMAL(10, 2)) CITYMONEY,");
	   sql.append("            SUM(CASE WHEN A.ASSISTANCE_TYPE = '01' THEN NVL(A.ASSISTANCE_PEOPLE_NUM, 0) ELSE 0 END) CITYPEOPLE,");
	   sql.append("            SUM(CASE WHEN A.ASSISTANCE_TYPE = '02' THEN 1 ELSE 0 END) COUNTRYCOUNT,");
	   sql.append("            CAST(SUM(CASE WHEN A.ASSISTANCE_TYPE = '02' THEN (NVL(A.ASSISTANCE_MONEY, 0) +");
	   sql.append("                        NVL(A.ASSISTANCE_CLASS_MONEY, 0)) ELSE 0 END) / 10000 AS DECIMAL(10, 2)) COUNTRYMONEY,");
	   sql.append("            SUM(CASE WHEN A.ASSISTANCE_TYPE = '02' THEN NVL(A.ASSISTANCE_PEOPLE_NUM, 0) ELSE 0 END) COUNTRYPEOPLE,");
	   sql.append("            SUM(CASE WHEN A.ASSISTANCE_TYPE = '03' THEN 1 ELSE 0 END) FIVECOUNT,");
	   sql.append("            CAST(SUM(CASE WHEN A.ASSISTANCE_TYPE = '03' THEN (NVL(A.ASSISTANCE_MONEY, 0) +");
	   sql.append("                        NVL(A.ASSISTANCE_CLASS_MONEY, 0)) ELSE 0 END) / 10000 AS DECIMAL(10, 2)) FIVEMONEY,");
	   sql.append("            SUM(CASE WHEN A.ASSISTANCE_TYPE = '03' THEN NVL(A.ASSISTANCE_PEOPLE_NUM, 0) ELSE 0 END) FIVEPEOPLE");
	   sql.append("           FROM SAM_FAMILY_TREATMENT A, BASEINFO_FAMILY_ARCHIVE B");
	   sql.append("          WHERE A.FAMILY_ID = B.FAMILY_ID");
	   sql.append("            AND A.APPLY_ID = B.APPLY_ID");
	   sql.append("            AND A.DOMICILE_CODE like '"+getAreaCodeLikePrefix(areaCode)+"%'");
	   sql.append("            AND A.BEGIN_DATE <= TO_CHAR(SYSDATE, 'YYYY-MM')");
	   sql.append("            AND A.END_DATE >= TO_CHAR(SYSDATE, 'YYYY-MM'))");
	   sql.append(" UNION ");
	   sql.append(" SELECT COUNT(*) COUNT,");
	   sql.append("        CAST(SUM(NVL(A.ASSISTANCE_MONEY, 0) +");
	   sql.append("                 NVL(A.ASSISTANCE_CLASS_MONEY, 0)) / 10000 AS DECIMAL(10, 2)) MONEYSUM,");
	   sql.append("        SUM(NVL(A.ASSISTANCE_PEOPLE_NUM, 0)) PEOPLENUM,");
	   sql.append("        RPAD(SUBSTR(A.DOMICILE_CODE, 1, "+getSubstrIndex(areaCode)+"), 12, '0') DOMICILE_CODE,");
	   sql.append("        GET_CITY_NAME(RPAD(SUBSTR(A.DOMICILE_CODE, 1, "+getSubstrIndex(areaCode)+"), 12, '0')) DOMICILE_NAME,");
	   sql.append("        SUM(CASE WHEN A.ASSISTANCE_TYPE = '01' THEN 1 ELSE 0 END) CITYCOUNT,");
	   sql.append("        CAST(SUM(CASE WHEN A.ASSISTANCE_TYPE = '01' THEN (NVL(A.ASSISTANCE_MONEY, 0) +");
	   sql.append("                    NVL(A.ASSISTANCE_CLASS_MONEY, 0)) ELSE 0 END) / 10000 AS DECIMAL(10, 2)) CITYMONEY,");
	   sql.append("        SUM(CASE WHEN A.ASSISTANCE_TYPE = '01' THEN NVL(A.ASSISTANCE_PEOPLE_NUM, 0) ELSE 0 END) CITYPEOPLE,");
	   sql.append("        SUM(CASE WHEN A.ASSISTANCE_TYPE = '02' THEN 1 ELSE 0 END) COUNTRYCOUNT,");
	   sql.append("        CAST(SUM(CASE WHEN A.ASSISTANCE_TYPE = '02' THEN (NVL(A.ASSISTANCE_MONEY, 0) +");
	   sql.append("                    NVL(A.ASSISTANCE_CLASS_MONEY, 0)) ELSE 0 END) / 10000 AS DECIMAL(10, 2)) COUNTRYMONEY,");
	   sql.append("        SUM(CASE WHEN A.ASSISTANCE_TYPE = '02' THEN NVL(A.ASSISTANCE_PEOPLE_NUM, 0) ELSE 0 END) COUNTRYPEOPLE,");
	   sql.append("        SUM(CASE WHEN A.ASSISTANCE_TYPE = '03' THEN 1 ELSE 0 END) FIVECOUNT,");
	   sql.append("        CAST(SUM(CASE WHEN A.ASSISTANCE_TYPE = '03' THEN (NVL(A.ASSISTANCE_MONEY, 0) +");
	   sql.append("                    NVL(A.ASSISTANCE_CLASS_MONEY, 0)) ELSE 0 END) / 10000 AS DECIMAL(10, 2)) FIVEMONEY,");
	   sql.append("        SUM(CASE WHEN A.ASSISTANCE_TYPE = '03' THEN NVL(A.ASSISTANCE_PEOPLE_NUM, 0) ELSE 0 END) FIVEPEOPLE");
	   sql.append("   FROM SAM_FAMILY_TREATMENT A, BASEINFO_FAMILY_ARCHIVE B");
	   sql.append("  WHERE A.FAMILY_ID = B.FAMILY_ID");
	   sql.append("    AND A.APPLY_ID = B.APPLY_ID");
	   sql.append("    AND A.DOMICILE_CODE like '"+getAreaCodeLikePrefix(areaCode)+"%'");
	   sql.append("    AND A.BEGIN_DATE <= TO_CHAR(SYSDATE, 'YYYY-MM')");
	   sql.append("    AND A.END_DATE >= TO_CHAR(SYSDATE, 'YYYY-MM')");
	   sql.append("  GROUP BY RPAD(SUBSTR(A.DOMICILE_CODE, 1, "+getSubstrIndex(areaCode)+"), 12, '0'))");
	   sql.append(" ORDER BY DOMICILE_CODE");

	   DataSet ds = executeDataset(sql.toString(), true);
	   ProceduresUtil.fixDataSet(ds);
	   return ds;
   }
	/**
    *  最近6个月的人数和户数统计
    * @param pset
    * @return
    */
   public DataSet queryBaseChangeByMonth(ParameterSet pset){
	   String areaCode= BspUtil.getOrganCode();
	   StringBuffer sql = new StringBuffer();
	   sql.append(" select   t.query_month,");
	   sql.append("  sum(t.city_family_num) city_family_num, sum(t.city_people_num) city_people_num,  sum(t.country_family_num) country_family_num, sum(t.country_people_num) country_people_num, ");
	   sql.append("  sum(t.five_family_num) five_family_num,sum(t.five_people_num) five_people_num ");
		
	   sql.append("   from SAM_ADMIN_QUERY t where t.domicile_code like ?  and t.query_month >=TO_CHAR(SYSDATE - INTERVAL '6' MONTH, 'YYYY-MM')");
	   sql.append(" group by t.query_month order by t.query_month ");
		
	   List<Integer> typeList=new ArrayList<Integer>();
	   List<String> objsList=new ArrayList<String>();
		if(areaCode.indexOf("000")!=-1){
			objsList.add(getAreaCodeLikePrefix(areaCode)+"%");
		}else {
			objsList.add(areaCode+"%");
		}
		typeList.add(Types.VARCHAR);
		int[] types = new int[typeList.size()];
		for (int i = 0; i < typeList.size(); i++) {
			types[i] = typeList.get(i);
		}
		Object[] args = objsList.toArray(new Object[objsList.size()]);
	   return  executeDataset(sql.toString(), types, args, true);
   }
   
   public DataSet queryBaseChange(){
	   String areaCode= BspUtil.getOrganCode();
	   StringBuffer sql = new StringBuffer();
	   sql.append("      select tid, domicile_code,  newsum,  stopsum,  citynew,  citystop,countrynew, countrystop,fivenew, fivestop from (  select ");
	   sql.append("'"+areaCode+"' tid,");
	   sql.append("        GET_CITY_NAME('"+areaCode+"') domicile_code,");
	   sql.append("   sum(case when   a.begin_date=to_char(sysdate, 'yyyy-mm')  then 1 else 0 end) newsum,");
	   sql.append("   sum(case when   a.end_date=to_char(sysdate, 'yyyy-mm')  then 1 else 0 end) stopsum,");
		  
	   sql.append("   sum(case when a.assistance_type = '01' and a.begin_date=to_char(sysdate, 'yyyy-mm')  then 1 else 0 end) citynew,");
	   sql.append("  sum(case when a.assistance_type = '01' and a.end_date=to_char(sysdate, 'yyyy-mm')  then 1 else 0 end) citystop,");
	 
	   sql.append("   sum(case when a.assistance_type = '02' and a.begin_date=to_char(sysdate, 'yyyy-mm')  then 1 else 0 end) countrynew,");
	   sql.append("  sum(case when a.assistance_type = '02' and a.end_date=to_char(sysdate, 'yyyy-mm')  then 1 else 0 end) countrystop,");
	
	   sql.append("   sum(case when a.assistance_type = '03' and a.begin_date=to_char(sysdate, 'yyyy-mm')  then 1 else 0 end) fivenew,");
	   sql.append("  sum(case when a.assistance_type = '03' and a.end_date=to_char(sysdate, 'yyyy-mm')  then 1 else 0 end) fivestop");
		
		
	   sql.append("  from  SAM_FAMILY_TREATMENT A, BASEINFO_FAMILY_ARCHIVE B  WHERE A.FAMILY_ID = B.FAMILY_ID  AND A.APPLY_ID = B.APPLY_ID ");
	   sql.append("  AND A.BEGIN_DATE <= to_char(sysdate, 'yyyy-mm')  AND A.END_DATE >= to_char(sysdate, 'yyyy-mm')");
	   sql.append("    AND A.DOMICILE_CODE like '"+getAreaCodeLikePrefix(areaCode)+"%'");
	   sql.append(" union ");
	   
	   sql.append("select   rpad(substr(a.domicile_code, 1, "+getSubstrIndex(areaCode)+"), 12, '0') tid, ");
	   sql.append(" get_city_name(rpad(substr(a.domicile_code, 1, "+getSubstrIndex(areaCode)+"), 12, '0')) domicile_code, ");
	   sql.append("   sum(case when   a.begin_date=to_char(sysdate, 'yyyy-mm')  then 1 else 0 end) newsum,");
	   sql.append("   sum(case when   a.end_date=to_char(sysdate, 'yyyy-mm')  then 1 else 0 end) stopsum,");
		  
	   sql.append("   sum(case when a.assistance_type = '01' and a.begin_date=to_char(sysdate, 'yyyy-mm')  then 1 else 0 end) citynew,");
	   sql.append("  sum(case when a.assistance_type = '01' and a.end_date=to_char(sysdate, 'yyyy-mm')  then 1 else 0 end) citystop,");
	 
	   sql.append("   sum(case when a.assistance_type = '02' and a.begin_date=to_char(sysdate, 'yyyy-mm')  then 1 else 0 end) countrynew,");
	   sql.append("  sum(case when a.assistance_type = '02' and a.end_date=to_char(sysdate, 'yyyy-mm')  then 1 else 0 end) countrystop,");
	
	   sql.append("   sum(case when a.assistance_type = '03' and a.begin_date=to_char(sysdate, 'yyyy-mm')  then 1 else 0 end) fivenew,");
	   sql.append("  sum(case when a.assistance_type = '03' and a.end_date=to_char(sysdate, 'yyyy-mm')  then 1 else 0 end) fivestop");
		
		
	   sql.append("  from  SAM_FAMILY_TREATMENT A, BASEINFO_FAMILY_ARCHIVE B  WHERE A.FAMILY_ID = B.FAMILY_ID  AND A.APPLY_ID = B.APPLY_ID ");
	   sql.append("  AND A.BEGIN_DATE <= to_char(sysdate, 'yyyy-mm')  AND A.END_DATE >= to_char(sysdate, 'yyyy-mm')");
	   sql.append("    AND A.DOMICILE_CODE like '"+getAreaCodeLikePrefix(areaCode)+"%'");
	   sql.append("  GROUP BY RPAD(SUBSTR(A.DOMICILE_CODE, 1, "+getSubstrIndex(areaCode)+"), 12, '0'))");
	   sql.append(" ORDER BY tid");
	   
	   System.out.println(sql.toString());
	   
	   DataSet ds = executeDataset(sql.toString(), true);
	   ProceduresUtil.fixDataSet(ds);
	   return ds;
	   
   }
   
   private String getAreaCodeLikePrefix(String areaCode) {
       if(areaCode.endsWith("0000000000")){//省370000000000
			return areaCode.substring(0,2);
		} else if (areaCode.endsWith("00000000")){//市370100000000
			return areaCode.substring(0,4);
		} else if (areaCode.endsWith("000000")){//县370104000000
			return areaCode.substring(0,6);
		} else if (areaCode.endsWith("000")){//乡370104003000
			return areaCode.substring(0,9);
		}
       return areaCode;
	}
   private int getSubstrIndex(String areaCode) {
       if(areaCode.endsWith("0000000000")){//省370000000000
		return 4;
		} else if (areaCode.endsWith("00000000")){//市370100000000
			return 6;
		} else if (areaCode.endsWith("000000")){//县370104000000
			return 9;
		} else if (areaCode.endsWith("000")){//乡370104003000
			return 12;
		}
	   return 12;
   }
}

